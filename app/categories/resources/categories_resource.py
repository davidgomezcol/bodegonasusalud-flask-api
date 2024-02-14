from flask import jsonify, request
from flask_restful import Resource
from pydantic import BaseModel, Field

from app.auth import auth_required
from app.db import session
from app.models import Category


class CategorySchema(BaseModel):
    """Category schema"""
    id: int = Field(None, description="Category ID")
    name: str = Field(..., min_length=3, max_length=255, description="Category name")
    user_id: int = Field(..., description="User ID")


class CategoryService:
    """Category service"""
    @classmethod
    def get_all_categories(cls):
        """Get all categories"""
        return session.query(Category).all()

    @classmethod
    def get_many_categories(cls, category_ids: list):
        """Get a category by ID"""
        return session.query(Category).filter(Category.id.in_(category_ids)).all()

    @classmethod
    def create_category(cls, category_data: CategorySchema, commit: bool = True):
        """Create a new category"""
        new_category = Category(**category_data.model_dump())
        session.add(new_category)

        if commit:
            session.commit()

        return new_category


class CategoriesResource(Resource):
    """Categories resource"""
    @auth_required
    def get(self):
        """Get all categories"""
        try:
            data = CategoryService.get_all_categories()

            categories = [CategorySchema(
              **category.__dict__
            ).model_dump() for category in data]

            return jsonify(categories)
        except Exception as e:
            return jsonify("Error: " + str(e))

    # @auth_required
    def post(self):
        """Create a new category"""
        try:
            data = request.json

            category = CategorySchema(**data)

            new_category = CategoryService.create_category(category)

            return jsonify({'message': f'Category {new_category.name} created successfully'})
        except Exception as e:
            return jsonify({'error': str(e)})
