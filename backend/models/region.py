from sqlalchemy import Column, Integer, String

from database import Base


class Region(Base):
    __tablename__ = "regions"

    region_id = Column(Integer, primary_key=True, index=True)

    region_name = Column(String, nullable=False, unique=True)

    country_code = Column(String, nullable=True)

    created_at = Column(
        String,
        nullable=False,
        server_default="CURRENT_TIMESTAMP"
    )