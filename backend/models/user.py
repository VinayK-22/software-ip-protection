from sqlalchemy import Column, Integer, String, Text

from database import Base


class User(Base):
    __tablename__ = "users"

    user_id = Column(Integer, primary_key=True, index=True)
    full_name = Column(Text, nullable=False)
    email = Column(Text, unique=True, nullable=False)
    password_hash = Column(Text, nullable=False)
    role = Column(
        Text,
        nullable=False,
        default="user"
    )
    created_at = Column(
        Text,
        nullable=False,
        server_default="CURRENT_TIMESTAMP"
    )