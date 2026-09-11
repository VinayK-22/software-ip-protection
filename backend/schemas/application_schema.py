from pydantic import BaseModel
from typing import Optional


class ApplicationCreate(BaseModel):
    user_id: int
    application_name: str
    description: Optional[str] = None


class ApplicationResponse(BaseModel):
    application_id: int
    user_id: int
    application_name: str
    description: Optional[str]
    status: str
    created_at: str
    updated_at: str

    class Config:
        from_attributes = True