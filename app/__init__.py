from flask import Flask
from flask_jwt_extended import JWTManager
from flask_restful import Api


def create_app(config_class=None, testing=False):
    """Create and configure an instance of the Flask application"""
    app = Flask(__name__)

    if config_class:
        app.config.from_object('config.Config')

    if testing:
        # Apply test configuration if testing is True
        app.config.from_object('config.TestConfig')
        app.config['SERVER_NAME'] = 'localhost:9000'

    # Set JWT configuration
    app.config['JWT_SECRET_KEY'] = 'your_secret_key'  # Replace with your actual JWT secret key
    app.config['JWT_TOKEN_LOCATION'] = ['headers', 'cookies']  # Add this line to specify api_token location
    app.config['JWT_HEADER_TYPE'] = 'Bearer'
    app.config['UPLOAD_FOLDER'] = 'media/product'
    app.config['DEBUG'] = True
    # app.config['JWT_ACCESS_COOKIE_NAME'] = 'your_access_cookie_name'

    # Initialize JWT
    JWTManager(app)

    api = Api(app)

    # Import and register resources here
    # pylint: disable=import-outside-toplevel, no-name-in-module
    from app.api_token.resources.token_resource import ApiTokenResource
    from app.products.resources.products_resource import ProductsResource
    from app.categories.resources.categories_resource import CategoriesResource
    from app.orders.resources.orders_resource import OrdersResource
    from app.templates.routes import templates_bp

    # from app.api_token.routes import token_bp
    # from app.products.routes import products_bp
    # from app.categories.routes import categories_bp

    api.add_resource(ApiTokenResource, '/api/get_token/')
    api.add_resource(ProductsResource, '/api/products/')
    api.add_resource(CategoriesResource, '/api/categories/')
    api.add_resource(OrdersResource, '/api/orders/')

    app.register_blueprint(templates_bp)
    # app.register_blueprint(token_bp)
    # app.register_blueprint(products_bp)
    # app.register_blueprint(categories_bp)

    return app
