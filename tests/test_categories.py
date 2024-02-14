import pytest

from app.categories.resources.categories_resource import CategoryService, CategorySchema
from .fixtures import setup_categories


def test_get_all_categories(database, setup_categories):
    """Test get all categories"""
    category1, category2 = setup_categories
    all_categories = CategoryService.get_all_categories()

    assert len(all_categories) == 2
    assert all_categories[0].name == category1.name
    assert all_categories[1].name == category2.name


def test_create_category(database):
    """Test create a new category"""
    new_category = {
        "name": "Test Category",
        "user_id": 1
    }
    category_schema = CategorySchema(**new_category)
    saved_category = CategoryService.create_category(category_schema)
    assert saved_category.id is not None
    assert saved_category.name == new_category["name"]
    assert saved_category.user_id == new_category["user_id"]


def test_get_category_by_id(database, setup_categories):
    """Test get a category by ID"""
    category1, category2 = setup_categories
    category = CategoryService.get_many_categories([category1.id])[0]
    assert category.name == category1.name


def test_invalid_category_data(database, setup_categories):
    """Test invalid category data"""
    with pytest.raises(Exception) as excinfo:
        new_category = {
            "name": "",
            "user_id": 1
        }
        category_schema = CategorySchema(**new_category)
        CategoryService.create_category(category_schema)
    assert "name" in str(excinfo.value)


def test_get_categories_by_ids(database, setup_categories):
    """Test get categories by IDs"""
    category1, category2 = setup_categories
    categories = CategoryService.get_many_categories([category1.id, category2.id])
    assert len(categories) == 2
    assert categories[0].name == category1.name
    assert categories[1].name == category2.name
