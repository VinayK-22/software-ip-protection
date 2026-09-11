from sqlalchemy import Column, Integer, String, Text, ForeignKey

from database import Base


class Application(Base):
    __tablename__ = "applications"

    application_id = Column(Integer, primary_key=True, index=True)

    user_id = Column(Integer, ForeignKey("users.user_id"), nullable=False)

    application_name = Column(String, nullable=False)

    description = Column(Text, nullable=True)

    status = Column(String, nullable=False, default="draft")

    created_at = Column(String, nullable=False)

    updated_at = Column(String, nullable=False)