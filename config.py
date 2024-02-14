class Config:
    """Base configuration"""
    SQLALCHEMY_DATABASE_URI = 'postgresql+psycopg2://postgres:postgres@db/postgres'


class TestConfig(Config):
    """Test configuration"""
    SQLALCHEMY_DATABASE_URI = \
        'postgresql+psycopg2://postgres:supersecretpassword@test_postgres/postgres_test'
