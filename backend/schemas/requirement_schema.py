from pydantic import BaseModel


class RequirementCreate(BaseModel):
    title: str
    description: str | None = None
    region_id: int
    ip_type_id: int
    priority: str = "medium"


class RequirementResponse(BaseModel):
    id: int
    title: str
    description: str | None
    region_id: int
    ip_type_id: int
    priority: str

    class Config:
        from_attributes = True