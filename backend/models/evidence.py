from sqlalchemy import Column, Integer, String, Text, ForeignKey
from database import Base


class Evidence(Base):
    __tablename__ = "evidence_documents"

    evidence_id = Column(
        Integer,
        primary_key=True,
        index=True
    )

    application_id = Column(
        Integer,
        ForeignKey("applications.application_id"),
        nullable=False
    )

    requirement_id = Column(
        Integer,
        ForeignKey("ip_requirements.requirement_id"),
        nullable=True
    )

    file_name = Column(
        String(255),
        nullable=False
    )

    file_path = Column(
        String(500),
        nullable=False
    )

    document_type = Column(
        String(100),
        nullable=True
    )

    description = Column(
        Text,
        nullable=True
    )

    uploaded_at = Column(
        String,
        nullable=False
    )