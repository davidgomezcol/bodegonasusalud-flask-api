from typing import Any

from sqlalchemy import Column, Integer, String, Float, Boolean, ForeignKey, Table, DateTime
from sqlalchemy.orm import relationship

from .db import Base


class User(Base):
    """User model."""
    __tablename__ = 'core_user'
    id: int = Column(Integer, primary_key=True)
    name: str = Column(String(255), nullable=False)
    email: str = Column(String(255), nullable=False)
    is_active: bool = Column(Boolean, default=False)
    is_superuser: bool = Column(Boolean, default=False)
    is_staff: bool = Column(Boolean, default=False)
    password: str = Column(String(255), nullable=False)


# Define the association table for the many-to-many relationship between products and categories
products_categories_association = Table(
    'core_products_category',
    Base.metadata,
    Column('products_id', Integer, ForeignKey('core_products.id')),
    Column('categories_id', Integer, ForeignKey('core_categories.id'))
)


class Product(Base):
    """Product model."""
    __tablename__ = 'core_products'
    id: int = Column(Integer, primary_key=True)
    name: str = Column(String(255), nullable=False)
    description: str = Column(String(255))
    price: float = Column(Float, nullable=False)
    weight: str = Column(String(50))
    units: str = Column(String(50))
    featured: bool = Column(Boolean)
    image: str = Column(String(500))
    user_id: int = Column(Integer, ForeignKey('core_user.id'))
    discount: float = Column(Float)
    categories = relationship(
        "Category",
        secondary=products_categories_association,
        backref="core_products",
        uselist=True
    )

    @property
    def image_url(self):
        """Return the image url for the product."""
        return f"/media/product/{self.image}"


class Category(Base):
    """Category model."""
    __tablename__ = 'core_categories'
    id: int = Column(Integer, primary_key=True)
    user_id: int = Column(Integer, ForeignKey('core_user.id'))
    name: str = Column(String(255), nullable=False)
    products = relationship(
        "Product",
        secondary=products_categories_association,
        backref="core_categories",
        uselist=True
    )


orders_association = Table(
    'core_orders_association',
    Base.metadata,
    Column('order_id', Integer, ForeignKey('core_orders.id')),
    Column('orderitem_id', Integer, ForeignKey('core_orderitem.id'))
)


class Orders(Base):
    """Orders model."""
    __tablename__ = 'core_orders'
    id = Column(Integer, primary_key=True)
    user_id = Column(Integer, ForeignKey('core_user.id'))
    order_status = Column(String(20), nullable=False, default='Created')
    payment_mode = Column(String(255), nullable=False)
    tracking_number = Column(String(150), nullable=True, unique=True)
    order_total = Column(Float, nullable=False)
    is_paid = Column(Boolean, default=False)
    order_date = Column(DateTime, nullable=False)
    updated_date = Column(DateTime, nullable=False)
    shipped_date = Column(DateTime, nullable=True)
    order_items = relationship("OrderItem", backref="core_orders", uselist=True)

    def __init__(self, *args: Any, **kwargs: Any):   # pylint: disable=useless-super-delegation
        super().__init__(*args, **kwargs)


class OrderItem(Base):
    """OrderItem model."""
    __tablename__ = 'core_orderitem'
    id = Column(Integer, primary_key=True)
    order_id = Column(Integer, ForeignKey('core_orders.id'))
    product_id = Column(Integer, ForeignKey('core_products.id'))
    quantity = Column(Integer, nullable=False)
    item_price = Column(Float, nullable=False)
    total_price = Column(Float, nullable=False)
    discount = Column(Float, nullable=False)
