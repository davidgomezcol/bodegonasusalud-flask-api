import pytest
import docker
import psycopg2
import time
from pytest_postgresql.janitor import DatabaseJanitor
from docker.errors import NotFound, DockerException
from sqlalchemy import create_engine, text
from sqlalchemy.orm.session import sessionmaker


POSTGRES_PASSWORD = 'supersecretpassword'
PORT = 5432
USER = 'postgres'
DB = 'postgres'


def wait_for_postgres(dbname, user, password, host, port):
    for _ in range(5):  # Increase timeout
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
    raise Exception("Cannot connect to PostgreSQL server")


@pytest.fixture(scope="session")
def psql_docker():
    client = docker.from_env()
    try:
        container = client.containers.run(
            image="postgres:13",
            auto_remove=True,
            environment=dict(
                POSTGRES_DB=f'{DB}_tmpl',
                POSTGRES_PASSWORD=POSTGRES_PASSWORD,
            ),
            name="test_postgres",
            detach=True,
            remove=True,
        )

    except DockerException as e:
        raise Exception(f"Error starting Docker container: {e}")

    # Connect the container to the Docker Compose network
    network_name = "django_react_webserver"  # Replace with the actual network name
    try:
        network = client.networks.get(network_name)
        network.connect(container)
    except NotFound as e:
        raise Exception(f"Error connecting to Docker network: {e}")

    # Wait for the PostgreSQL server to start
    wait_for_postgres(f'{DB}_tmpl', USER, POSTGRES_PASSWORD, "test_postgres", PORT)  # Use localhost as host name

    yield

    container.stop()


@pytest.fixture(scope="session")
def database(psql_docker):
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

    engine = create_engine(f'postgresql://{USER}:{POSTGRES_PASSWORD}@test_postgres:{PORT}/{DB}_test')
    test_session = sessionmaker(bind=engine)
    test_session = test_session()

    with open('/opt/project/flask_api/schema.sql', 'r') as f:
        sql_statements = f.read()
    sql_statements_text = text(sql_statements)
    test_session.execute(sql_statements_text)
    test_session.commit()
    test_session.close()

    yield engine
    janitor.drop()


# @pytest.fixture(scope="session")
# def session_maker(database):
#     """Create a session to interact with the database"""
#     return sessionmaker(bind=database)
#
#
# @pytest.fixture(scope="function")
# def session(database, session_maker):
#     """Create a session to interact with the database"""
#     connection = database.connect()
#     transaction = connection.begin()
#     test_session = session_maker(bind=connection)
#
#     yield test_session
#
#     test_session.close()
#     transaction.rollback()
#     connection.close()


    # with open('/opt/project/flask_api/schema.sql', 'r') as f:
    #     sql_statements = f.read()
    #
    # sql_statements_text = text(sql_statements)
    # session.execute(sql_statements_text)
    # session.commit()

# pg_dump -U postgres -h db -p 5432 --no-owner --no-privileges --file=complete_dump.sql postgres
