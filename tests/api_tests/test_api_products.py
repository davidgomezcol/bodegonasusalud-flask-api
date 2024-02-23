import io

from flask_api.app.products.resources.products_resource import ProductService
from flask_api.tests.fixtures import _setup_categories, _setup_products, auth_client


def test_get_api_all_products(app, database, auth_client, _setup_products):
    """Test that the api gets all products"""
    product1, product2 = _setup_products
    category1, category2 = product1.category[0], product2.category[0]
    response = auth_client.get('/api/products/')
    assert response.status_code == 200
    data = response.get_json()
    assert len(data) == 2
    assert data[0]['name'] == product1.name
    assert data[1]['name'] == product2.name
    assert data[0]['category'][0] == category1.name
    assert data[1]['category'][0] == category2.name


def test_post_api_creates_a_new_product(database, auth_client, _setup_categories):
    """Test that the api creates a new product"""
    _, category2 = _setup_categories
    new_product = {
        "name": "Test Product _ create",
        "description": "Test Product",
        "price": 100.0,
        "weight": 100.0,
        "units": "kg",
        "featured": True,
        "user_id": 1,
        "discount": 10.0,
        "category": [category2.id]
    }
    image = bytes([0, 1, 2, 3, 4] * 1000)
    new_product['image'] = (io.BytesIO(image), 'test.jpg')
    response = auth_client.post(
        '/api/products/',
        data=new_product,
        content_type='multipart/form-data',
    )
    assert response.status_code == 200
    data = response.get_json()

    assert data['message'] == f'Product {new_product["name"]} created successfully'
    posted_product = ProductService.get_all_products()[0]

    assert posted_product.name == new_product['name']
    assert posted_product.description == new_product['description']
    assert posted_product.price == new_product['price']
    assert posted_product.weight == str(new_product['weight'])
    assert posted_product.units == new_product['units']
    assert posted_product.featured == new_product['featured']
    assert '.jpg' in posted_product.image
    assert posted_product.user_id == new_product['user_id']
    assert posted_product.discount == new_product['discount']
    assert posted_product.category[0].name == category2.name
