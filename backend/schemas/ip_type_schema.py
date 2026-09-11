from pydantic import BaseModel
from datetime import datetime


class IPTypeCreate(BaseModel):
    ip_type_name: str
    description: str | None = None


class IPTypeResponse(BaseModel):
    ip_type_id: int
    ip_type_name: str
    description: str | None = None
    created_at: datetime

    class Config:
        from_attributes = True