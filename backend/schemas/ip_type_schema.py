
from pydantic import BaseModel


class IPTypeCreate(BaseModel):
    name: str
    description: str


class IPTypeResponse(BaseModel):
    id: int
    name: str
    description: str

    class Config:
        from_attributes = True