from pydantic import BaseModel


class ApplicationCreate(BaseModel):
    name: str
    description: str | None = None
    owner_id: int
    status: str = "draft"


class ApplicationResponse(BaseModel):
    id: int
    name: str
    description: str | None
    owner_id: int
    status: str

    class Config:
        from_attributes = True