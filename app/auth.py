from functools import wraps

from flask import jsonify, g, current_app
from flask_jwt_extended import get_jwt_identity, jwt_required

from .models import User


def get_current_user():
    """Get the current user from the JWT api_token"""
    session = current_app.db_session.get_session()
    current_user_id = get_jwt_identity()
    current_user = session.query(User).filter_by(id=current_user_id).first()
    return current_user


def auth_required(fn):
    """Decorator to require authentication for a view function"""
    @wraps(fn)
    @jwt_required()
    def decorated_function(*args, **kwargs):
        current_user = get_current_user()
        if not current_user:
            return jsonify(message='Authentication required'), 401
        g.current_user = current_user
        return fn(*args, **kwargs)
    return decorated_function
