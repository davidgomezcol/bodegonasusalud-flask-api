from flask import current_app
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

Base = declarative_base()


class DatabaseSession:
    """Database class"""
    def __init__(self, config=None):
        self.session = sessionmaker()
        self.engine = create_engine(
            config.SQLALCHEMY_DATABASE_URI
        ) if hasattr(
            config, 'SQLALCHEMY_DATABASE_URI'
        ) else create_engine(
            current_app.config['SQLALCHEMY_DATABASE_URI']
        )
        self._session = None

    def get_session(self):
        """Get a session"""
        if self._session is None:
            self.session.configure(bind=self.engine)
            self._session = self.session()
        return self._session

    def close_session(self):
        """Close the session"""
        if self._session is not None:
            self._session.close()
            self._session = None

    def set_base(self):
        """Set the base"""
        Base.metadata.bind = self.engine
