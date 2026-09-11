from pydantic import BaseModel
from datetime import datetime


class RequirementCreate(BaseModel):
    ip_type_id: int
    region_id: int
    requirement_title: str
    requirement_description: str
    action_required: str
    mandatory: bool = True
    source_name: str | None = None
    source_url: str | None = None


class RequirementResponse(BaseModel):
    requirement_id: int
    ip_type_id: int
    region_id: int
    requirement_title: str
    requirement_description: str
    action_required: str
    mandatory: bool
    source_name: str | None = None
    source_url: str | None = None
    created_at: datetime

    class Config:
        from_attributes = True
        
class RequirementUpdate(BaseModel):
    ip_type_id: int
    region_id: int
    requirement_title: str
    requirement_description: str
    action_required: str
    mandatory: bool = True
    source_name: str | None = None
    source_url: str | None = None