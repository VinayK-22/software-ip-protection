
from sqlalchemy import Column, Integer, String

from database import Base


class Region(Base):
    __tablename__ = "regions"

    id = Column(Integer, primary_key=True, index=True)

    name = Column(
        String(100),
        unique=True,
        nullable=False
    )

    code = Column(
        String(10),
        unique=True,
        nullable=False
    )