import os
import uuid
from typing import Union

from flask import jsonify, request, current_app as app
from flask_restful import Resource
from pydantic import BaseModel, Field
from werkzeug.datastructures import FileStorage
from werkzeug.utils import secure_filename

from app.auth import auth_required
from app.categories.resources.categories_resource import CategoryService
from app.db import session
from app.decorators import validate_allowed_image
from app.models import Product


class ProductSchema(BaseModel):
    """Product schema"""
    id: int = Field(None, description="Product ID")
    name: str = Field(..., min_length=3, max_length=255, description="Product name")
    description: str = Field(..., min_length=3, max_length=500, description="Product description")
    price: float = Field(..., description="Product price")
    weight: float = Field(..., description="Product weight")
    units: str = Field(..., min_lenght=1, max_length=50, description="Product units")
    featured: bool = Field(..., description="Product featured")
    image: str = Field(..., description="Image file path")
    user_id: int = Field(..., description="User ID")
    discount: Union[float, None] = Field(None, description="Product discount")
    category: list[Union[int, str]] = Field(default_factory=list, description="Category ID")


class ProductService:
    """Product service"""
    @classmethod
    def get_all_products(cls):
        """Get all products"""
        return session.query(Product).all()

    @classmethod
    def create_product(cls, product_data: ProductSchema, commit: bool = True):
        """
            Create a new product
        """
        new_product = Product(**product_data.model_dump(exclude={'categories'}))
        new_product.categories = CategoryService.get_many_categories(
            category_ids=product_data.categories
        )

        session.add(new_product)

        if commit:
            session.commit()

        return new_product

    @classmethod
    def _save_image(cls, image: FileStorage):
        """Saves an image to the server and returns the path"""
        filename_extension = os.path.splitext(image.filename)[1]
        filename = str(uuid.uuid4()) + filename_extension
        filename = secure_filename(filename)
        image_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
        image.save(image_path)
        return f"product/{filename}"


class ProductsResource(Resource):
    """Products resource"""

    # @auth_required
    def get(self):
        """Get all products"""
    # Use SQLAlchemy to query the data and perform the join
        try:
            data = ProductService.get_all_products()

            products = [
                ProductSchema(
                    **dict(product.__dict__.items()),
                    category=[category.name for category in product.categories]
                ).model_dump()
                for product in data
            ]

            for product in products:
                product['image'] = f"http://localhost/media/{product['image']}"

            return jsonify(products)
        except Exception as e:
            return jsonify("Error: " + str(e))

    @auth_required
    @validate_allowed_image
    def post(self):
        """Create a new product"""
        try:
            product_data = dict(request.form)
            product_data['categories'] = list(product_data['categories'])
            product_data['image'] = ProductService._save_image(request.files.get('image'))

            product_data = ProductSchema(**product_data)

            ProductService.create_product(
                product_data=product_data,
            )

            return jsonify({'message': 'Product created successfully'})
        except Exception as e:
            return jsonify({'error': str(e)})
