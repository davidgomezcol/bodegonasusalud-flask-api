from functools import wraps
from typing import Any

from flask import request, jsonify

ALLOWED_EXTENSIONS = {'jpg', 'jpeg', 'png', 'gif'}


def allowed_file(filename: str):
    """Check if the file extension is allowed."""
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS


def validate_allowed_image(f: callable):
    """Decorator to validate if the request contains an image file and if it is allowed."""
    @wraps(f)
    def decorated_function(*args: Any, **kwargs: Any):
        if 'image' not in request.files:
            return jsonify({'error': 'No image part'})

        image_file = request.files['image']
        if image_file and allowed_file(image_file.filename):
            return f(*args, **kwargs)
        return jsonify({'error': 'Invalid or no image file provided'})

    return decorated_function
