from flask_api.tests.fixtures import _setup_categories, auth_client


def test_get_api_gets_all_categories(database, auth_client, _setup_categories):
    """Test that the api gets all categories"""
    category1, category2 = _setup_categories
    response = auth_client.get('/api/categories/')
    assert response.status_code == 200
    data = response.get_json()
    assert len(data) == 2
    assert data[0]['name'] == category1.name
    assert data[1]['name'] == category2.name


def test_post_api_creates_a_new_category(database, auth_client):
    """Test that the api creates a new category"""
    new_category = {
        "name": "Test Category",
        "user_id": 1
    }
    response = auth_client.post('/api/categories/', json=new_category)
    assert response.status_code == 200
    data = response.get_json()
    assert data['message'] == f'Category {new_category["name"]} created successfully'
