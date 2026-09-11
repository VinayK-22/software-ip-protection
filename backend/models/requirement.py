from sqlalchemy import Column, Integer, String, Text, ForeignKey, Boolean, DateTime, text

from database import Base


class Requirement(Base):
    __tablename__ = "ip_requirements"

    requirement_id = Column(
        Integer,
        primary_key=True,
        index=True
    )

    ip_type_id = Column(
        Integer,
        ForeignKey("ip_types.ip_type_id"),
        nullable=False
    )

    region_id = Column(
        Integer,
        ForeignKey("regions.region_id"),
        nullable=False
    )

    requirement_title = Column(
        String(255),
        nullable=False
    )

    requirement_description = Column(
        Text,
        nullable=False
    )

    action_required = Column(
        Text,
        nullable=False
    )

    mandatory = Column(
        Boolean,
        nullable=False,
        default=True
    )

    source_name = Column(
        String(255),
        nullable=True
    )

    source_url = Column(
        Text,
        nullable=True
    )

    created_at = Column(
        DateTime,
        nullable=False,
        server_default=text("CURRENT_TIMESTAMP")
    )