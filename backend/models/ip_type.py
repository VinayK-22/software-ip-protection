from sqlalchemy import Column, Integer, String, Text

from database import Base


class IPType(Base):
    __tablename__ = "ip_types"

    id = Column(Integer, primary_key=True, index=True)

    name = Column(
        String(100),
        unique=True,
        nullable=False
    )

    description = Column(
        Text,
        nullable=True
    )