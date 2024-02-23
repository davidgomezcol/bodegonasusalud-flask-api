import secrets
import string
from datetime import datetime
from typing import Optional

from flask import jsonify, request, current_app
from flask_restful import Resource
from pydantic import BaseModel, Field, field_validator

from flask_api.app.auth import auth_required
from flask_api.app.models import Orders, OrderItem


def _generate_tracking_number(length: int = 10) -> str:
    characters = string.ascii_letters + string.digits
    return ''.join(secrets.choice(characters) for _ in range(length)).upper()


class OrderItemSchema(BaseModel):
    """Order item schema"""
    id: int = Field(None, description="Order item ID")
    product_id: int = Field(..., description="Product ID")
    quantity: int = Field(..., description="Quantity")
    item_price: float = Field(..., description="Price")
    total_price: Optional[float] = Field(None, description="Total price")
    order_id: int = Field(default=Orders.id, description="Order ID")
    discount: float = Field(..., description="Discount")

    @classmethod
    @field_validator('total_price')
    def _validate_total_price(cls, total_price: Optional[float], values: dict):
        if total_price is None:
            total_price = (
                        values['item_price'] * values['quantity'] - values['item_price'] * values['quantity'] * values[
                    'discount'] / 100)
        if total_price <= 0:
            raise ValueError('Total price must be greater than 0')
        return total_price


class OrderSchema(BaseModel):
    """Order schema"""
    id: int = Field(None, description="Order ID")
    user_id: int = Field(..., description="User ID")
    order_status: str = Field(default="Created", description="Order status")
    payment_mode: str = Field(..., description="Payment mode")
    tracking_number: str = Field(default_factory=_generate_tracking_number, description="Tracking number")
    order_total: Optional[float] = Field(default=None, description="Order total")
    is_paid: bool = Field(..., description="Is paid")
    order_date: datetime = Field(default_factory=datetime.now, description="Order date")
    updated_date: datetime = Field(default_factory=datetime.now, description="Updated date")
    shipped_date: Optional[datetime] = Field(default=None, description="Shipped date")
    order_items: list[OrderItemSchema] = Field(..., description="List of order items")

    @classmethod
    @field_validator('order_total')
    def _validate_order_total(cls, order_total: Optional[float], values: dict):
        if order_total is None:
            order_total = 0
            for order_item in values['order_items']:
                order_total += order_item['total_price']
        if order_total <= 0:
            raise ValueError('Order total must be greater than 0')
        return order_total


class OrderService:
    """Order service"""
    @classmethod
    def get_all_orders(cls):
        """Get all orders"""
        session = current_app.db_session.get_session()
        return session.query(Orders).all()

    @classmethod
    def create_order(cls, order_data: OrderSchema, commit: bool = True):
        """Create a new order"""
        session = current_app.db_session.get_session()
        new_order = Orders(**order_data.model_dump(exclude={'order_items'}))
        # new_order.order_items = [
        #     OrderItemsService.create_order_item(order_item, False) for order_item in order_data.order_items
        # ]
        new_order.order_items = OrderItemsService.create_many_order_items(order_data.order_items, False)
        # new_order.order_total = cls.calculate_order_totals(order_data)
        session.add(new_order)

        if commit:
            session.commit()
        return new_order

    # @classmethod
    # def calculate_order_totals(cls, order: OrderSchema):
    #     """Calculate totals"""
    #     order_total = 0
    #     for order_item in order.order_items:
    #         order_total += order_item.total_price
    #     return order_total


class OrderItemsService:
    """Order items service"""
    @classmethod
    def get_all_order_items(cls):
        """Get all order items"""
        session = current_app.db_session.get_session()
        return session.query(OrderItem).all()

    @classmethod
    def get_many_order_items(cls, order_item_ids: list):
        """Get a order item by ID"""
        session = current_app.db_session.get_session()
        return session.query(OrderItem).filter(OrderItem.id.in_(order_item_ids)).all()

    @classmethod
    def create_order_item(cls, order_item_data: OrderItemSchema, commit: bool = True):
        """Create a new order item"""
        session = current_app.db_session.get_session()
        new_order_item = OrderItem(**order_item_data.model_dump())
        session.add(new_order_item)

        if commit:
            session.commit()
        return new_order_item

    @classmethod
    def create_many_order_items(cls, order_items_list: list[OrderItemSchema], commit: bool = True):
        """Create a new order item"""
        session = current_app.db_session.get_session()
        new_order_items_list = []
        for order_item in order_items_list:
            # order_item.total_price = cls.calculate_order_item_totals(order_item)
            new_order_items_list.append(OrderItem(**order_item.model_dump()))

        session.add_all(new_order_items_list)

        if commit:
            session.commit()
        return new_order_items_list

    # @classmethod
    # def calculate_order_item_totals(cls, order_item: OrderItemSchema):
    #     """Calculate totals"""
    #     if order_item.discount:
    #         order_item_total = order_item.item_price * order_item.quantity
    #         order_item_discount = order_item.discount
    #         return order_item_total - (order_item_total * order_item_discount / 100)
    #     return order_item.item_price * order_item.quantity


class OrdersResource(Resource):
    """Orders resource"""
    @auth_required
    def get(self):
        """Get all orders"""
        try:
            data = OrderService.get_all_orders()

            orders = [OrderSchema(
                **dict(order.__dict__.items()),
                order_items=[OrderItemSchema(
                    **dict(order_item.__dict__.items())
                ).model_dump() for order_item in order.order_items]
            ).model_dump() for order in data]

            return jsonify(orders)
        except Exception as e:
            return jsonify("Error: " + str(e))

    # @auth_required
    def post(self):
        """Create a new order"""
        try:
            data = request.json
            order_items = [OrderItemSchema(**order_item) for order_item in data.pop('order_items', [])]
            order = OrderSchema(order_items=order_items, **data)

            OrderService.create_order(order)

            return jsonify({'message': 'Order created successfully'})
        except Exception as e:
            return jsonify({'error': str(e)})
