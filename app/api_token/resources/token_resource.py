from flask import jsonify, request
from flask_jwt_extended import create_access_token
from flask_restful import Resource
from passlib.hash import django_pbkdf2_sha256

from app.db import session
from app.models import User


class ApiTokenResource(Resource):
    """API token resource"""
    def post(self):
        """Get a api_token for a user"""
        data = request.get_json()
        if not data:
            return jsonify({"message": "Missing JSON in request"})

        email = data.get('email')
        password = data.get('password')

        # Validate the user credentials here (you may use your authentication method here)
        # For example, you can check if the provided email and password match a user in the database
        # If the credentials are valid, create an access api_token and return it to the user
        if email and password:
            user = session.query(User).filter_by(email=email).first()
            if (user and django_pbkdf2_sha256.verify(password, user.password)
                    and user.is_active):
                access_token = create_access_token(
                    identity=user.id,
                    additional_claims={
                        "username": user.email,
                        "role": user.is_staff,
                        "is_superuser": user.is_superuser
                    }
                )
                return jsonify({"access_token": access_token})
        return jsonify({"message": "Invalid credentials"})
