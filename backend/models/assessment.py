from sqlalchemy import Column, Integer, String, Text, ForeignKey, Boolean

from database import Base


class Assessment(Base):
    __tablename__ = "assessments"

    id = Column(Integer, primary_key=True, index=True)

    application_id = Column(
        Integer,
        ForeignKey("applications.application_id"),
        nullable=False
    )

    requirement_id = Column(
        Integer,
        ForeignKey("ip_requirements.requirement_id"),
        nullable=False
    )

    status = Column(
        String(30),
        nullable=False,
        default="pending"
    )

    is_compliant = Column(
        Boolean,
        nullable=False,
        default=False
    )

    notes = Column(
        Text,
        nullable=True
    )