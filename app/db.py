from config import Config, TestConfig
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

Session = sessionmaker()

# Create the engine and session
# if TestConfig.TESTING:
#     engine = create_engine(TestConfig.SQLALCHEMY_DATABASE_URI)
# else:
engine = create_engine(Config.SQLALCHEMY_DATABASE_URI)


Base = declarative_base()
Base.metadata.bind = engine
Session = sessionmaker(bind=engine)
session = Session()
