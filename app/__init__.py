import os

from flask import Flask
from flask_jwt_extended import JWTManager
from flask_restful import Api

from db import DatabaseSession


def create_app(config_class=None, testing=False):
    """Create and configure an instance of the Flask application"""
    app = Flask(__name__)

    if config_class:
        app.config.from_object(config_class)

    if testing:
        # Apply test configuration if testing is True
        app.config.from_object('flask_api.config.TestConfig')
        app.config['SERVER_NAME'] = 'localhost:9000'
        app.config['TESTING'] = True

    with app.app_context():
        app.db_session = DatabaseSession(config=app.config)

    # Set JWT configuration
    app.config['JWT_SECRET_KEY'] = 'your_secret_key'  # Replace with your actual JWT secret key
    app.config['JWT_TOKEN_LOCATION'] = ['headers', 'cookies']  # Add this line to specify api_token location
    app.config['JWT_HEADER_TYPE'] = 'Bearer'
    app.config['UPLOAD_FOLDER'] = 'media/product'
    app.config['DEBUG'] = True
    try:
        upload_folder = os.path.join('/opt/project/flask_api/', app.config['UPLOAD_FOLDER'])
        print(f"Creating upload folder at: {upload_folder}")
        os.makedirs(upload_folder, exist_ok=True)
    except Exception as e:
        print(f"Failed to create upload folder: {e}")
    # app.config['JWT_ACCESS_COOKIE_NAME'] = 'your_access_cookie_name'

    # Initialize JWT
    JWTManager(app)

    api = Api(app)

    # Import and register resources here
    # pylint: disable=import-outside-toplevel, no-name-in-module
    from flask_api.app.api_token.resources.token_resource import ApiTokenResource
    from flask_api.app.products.resources.products_resource import ProductsResource
    from flask_api.app.categories.resources.categories_resource import CategoriesResource
    from flask_api.app.orders.resources.orders_resource import OrdersResource
    from flask_api.app.templates.routes import templates_bp

    api.add_resource(ApiTokenResource, '/api/get_token/')
    api.add_resource(ProductsResource, '/api/products/')
    api.add_resource(CategoriesResource, '/api/categories/')
    api.add_resource(OrdersResource, '/api/orders/')

    app.register_blueprint(templates_bp)

    return app
