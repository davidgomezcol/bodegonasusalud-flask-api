import pytest
from flask import current_app
from passlib.hash import django_pbkdf2_sha256

from categories.resources.categories_resource import CategoryService, CategorySchema
from flask_api.app.models import User
from flask_api.app.products.resources.products_resource import ProductSchema, ProductService

PASSWORD = 'test_password'
HASHED_PASSWORD = django_pbkdf2_sha256.encrypt(PASSWORD, rounds=120000, salt_size=16)


@pytest.fixture
def _test_user(app, database):
    """Fixture to create a test user"""
    session = app.db_session.get_session()
    testing_user = User(
        email="test_user@bodegonasusalud.com",
        name="Test User",
        last_name="Test Last Name",
        address="Test Address",
        city="Test City",
        is_active=True,
        id_number="1000",
        id_type="CC",
        phone="1234567890",
        state="Test State",
        zip_code="12345",
        password=HASHED_PASSWORD
    )
    session.add(testing_user)
    session.commit()
    return testing_user


@pytest.fixture
def _simple_client(app):
    """Fixture to create a simple client"""
    return app.test_client()


@pytest.fixture
def auth_client(database):
    """Fixture to create an authenticated client"""
    with current_app.app_context():
        with current_app.db_session.get_session():
            test_client = current_app.test_client()
            response = test_client.post('/api/get_token/', json={
                'email': 'admin@local.com',
                'password': '123456'
            })
            token = response.get_json()['access_token']
            test_client.environ_base['HTTP_AUTHORIZATION'] = f'Bearer {token}'

            return test_client


@pytest.fixture
def _setup_categories(database):
    """Fixture to create test categories"""
    category1 = CategoryService.create_category(CategorySchema(name="Test Category", user_id=1))
    category2 = CategoryService.create_category(CategorySchema(name="Test Category2", user_id=1))
    return category1, category2


@pytest.fixture
def _setup_products(database, _setup_categories):
    """Fixture to create test products"""
    category1, category2 = _setup_categories
    product1 = ProductService.create_product(ProductSchema(
        name="Test Product",
        description="Test Product",
        price=100.0,
        weight=100.0,
        units="kg",
        featured=True,
        image="product/test.jpg",
        user_id=1,
        discount=10.0,
        category=[category1.id]
    ))
    product2 = ProductService.create_product(ProductSchema(
        name="Test Product2",
        description="Test Product2",
        price=100.0,
        weight=100.0,
        units="kg",
        featured=True,
        image="product/test2.jpg",
        user_id=1,
        discount=10.0,
        category=[category2.id]
    ))
    return product1, product2
