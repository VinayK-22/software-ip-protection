from sqlalchemy import Column, Integer, ForeignKey
from database import Base


class ApplicationRegion(Base):
    __tablename__ = "application_regions"

    application_id = Column(
        Integer,
        ForeignKey("applications.application_id"),
        primary_key=True
    )

    region_id = Column(
        Integer,
        ForeignKey("regions.region_id"),
        primary_key=True
    )