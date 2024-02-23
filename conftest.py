import time

import docker
import psycopg2
import pytest
from docker.errors import NotFound, DockerException
from flask import current_app
from pytest_postgresql.janitor import DatabaseJanitor
from sqlalchemy import text

from db import DatabaseSession
from flask_api.app import create_app
from flask_api.config import TestConfig

POSTGRES_PASSWORD = 'supersecretpassword'
PORT = 5432
USER = 'postgres'
DB = 'postgres'


@pytest.fixture(scope="session", autouse=True)
def app():
    """Create and configure a new app instance for each test."""
    app = create_app(testing=True)
    with app.app_context():
        yield app


@pytest.fixture(scope="function", autouse=True)
def clear_database(app):
    """Clear the database after each test."""
    yield
    # This code is run after each test
    session = current_app.db_session.get_session()
    session.execute(text('DELETE FROM core_products_category'))
    session.execute(text('DELETE FROM core_products CASCADE'))
    session.execute(text('DELETE FROM core_categories CASCADE'))
    session.execute(text('DELETE FROM core_orders CASCADE'))
    session.execute(text('DELETE FROM core_orderitem CASCADE'))
    session.commit()
    current_app.db_session.close_session()


def wait_for_postgres(dbname, user, password, host, port):
    """Wait for the PostgreSQL server to start."""
    for _ in range(5):  # Try 5 times
        try:
            conn = psycopg2.connect(
                dbname=dbname,
                user=user,
                password=password,
                host=host,
                port=port,
            )
            conn.close()
            return
        except psycopg2.OperationalError:
            time.sleep(5)
    raise ConnectionError("Cannot connect to PostgreSQL server")


@pytest.fixture(scope="session")
def _psql_docker():
    """Start a PostgreSQL server using Docker."""
    client = docker.from_env()
    try:
        container = client.containers.run(
            image="postgres:13",
            auto_remove=True,
            environment={
                'POSTGRES_DB': f'{DB}_tmpl',
                'POSTGRES_PASSWORD': POSTGRES_PASSWORD,
            },
            name="test_postgres",
            detach=True,
            remove=True,
        )

    except DockerException as e:
        raise RuntimeError(f"Error starting Docker container: {e}") from e

    # Connect the container to the Docker Compose network
    network_name = "django_react_webserver"  # Replace with the actual network name
    try:
        network = client.networks.get(network_name)
        network.connect(container)
    except NotFound as e:
        raise ConnectionError(f"Error connecting to Docker network: {e}") from e

    # Wait for the PostgreSQL server to start
    wait_for_postgres(f'{DB}_tmpl', USER, POSTGRES_PASSWORD, "test_postgres", PORT)

    yield

    container.stop()


@pytest.fixture(scope="session")
def _db_session():
    """Create a database session for the tests."""
    db_session = DatabaseSession(config=TestConfig)
    db_session.set_base()
    return db_session


@pytest.fixture(scope="session")
def database(_psql_docker, _db_session):
    """Create a database for the tests"""
    janitor = DatabaseJanitor(
        user=USER,
        host="test_postgres",
        port=PORT,
        dbname=f'{DB}_test',
        version=13,
        password=POSTGRES_PASSWORD,
    )
    janitor.init()

    with open('/opt/project/flask_api/schema.sql', 'r', encoding='utf-8') as f:
        sql_statements = f.read()
    sql_statements_text = text(sql_statements)
    session = _db_session.get_session()
    session.execute(sql_statements_text)
    session.commit()
    session.close()

    yield session

    current_app.db_session.close_session()
    janitor.drop()

# If we need to dump a new schema, we can use the following command:
# pg_dump -U postgres -h db -p 5432 --no-owner --no-privileges --file=complete_dump.sql postgres
