
from sqlalchemy import Column, Integer, String, Text, ForeignKey

from database import Base


class Requirement(Base):
    __tablename__ = "requirements"

    id = Column(Integer, primary_key=True, index=True)

    title = Column(
        String(200),
        nullable=False
    )

    description = Column(
        Text,
        nullable=True
    )

    region_id = Column(
        Integer,
        ForeignKey("regions.id"),
        nullable=False
    )

    ip_type_id = Column(
        Integer,
        ForeignKey("ip_types.id"),
        nullable=False
    )

    priority = Column(
        String(20),
        nullable=False,
        default="medium"
    )