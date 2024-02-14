import pytest
from categories.resources.categories_resource import CategoryService, CategorySchema
from app.products.resources.products_resource import ProductSchema, ProductService


@pytest.fixture
def setup_categories():
    """Fixture to create test categories"""
    # with session.execute():
    category1 = CategoryService.create_category(CategorySchema(name="Test Category", user_id=1))
    category2 = CategoryService.create_category(CategorySchema(name="Test Category2", user_id=1))
    # session.commit()
    return category1, category2


@pytest.fixture
def setup_products():
    """Fixture to create test products"""
    # with session.execute():
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
        categories=[1]
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
        categories=[2]
    ))
    # session.commit()
    return product1, product2
