from sqlalchemy import Column, Integer, String, Text, DateTime, text

from database import Base


class IPType(Base):
    __tablename__ = "ip_types"

    ip_type_id = Column(
        Integer,
        primary_key=True,
        index=True
    )

    ip_type_name = Column(
        String(100),
        nullable=False
    )

    description = Column(
        Text,
        nullable=True
    )

    created_at = Column(
        DateTime,
        nullable=False,
        server_default=text("CURRENT_TIMESTAMP")
    )