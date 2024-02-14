from app.categories.resources.categories_resource import CategoryService
from app.products.resources.products_resource import ProductSchema, ProductService
from .fixtures import setup_categories


def test_create_product(setup_categories):
    """Test create a new product"""
    category1, category2 = setup_categories
    new_product = {
        "name": "Test Product _ create",
        "description": "Test Product",
        "price": 100.0,
        "weight": 100.0,
        "units": "kg",
        "featured": True,
        "image": "product/test.jpg",
        "user_id": 1,
        "discount": 10.0,
        "categories": [category1.id]
    }
    product_schema = ProductSchema(**new_product)
    saved_product = ProductService.create_product(product_schema)
    assert saved_product.id is not None
    assert saved_product.name == new_product["name"]
    assert saved_product.description == new_product["description"]
    assert saved_product.price == new_product["price"]
    assert float(saved_product.weight) == new_product["weight"]
    assert saved_product.units == new_product["units"]
    assert saved_product.featured == new_product["featured"]
    assert saved_product.image == new_product["image"]
    assert saved_product.user_id == new_product["user_id"]
    assert saved_product.discount == new_product["discount"]
    assert saved_product.categories[0].id == category1.id


def test_get_all_products():
    """Test get all products"""
    # product1, product2 = setup_products
    all_products = ProductService.get_all_products()
    categories = CategoryService.get_all_categories()

    assert len(all_products) == 2
    # assert all_products[0].name == product1.name
    # assert all_products[1].name == product2.name
