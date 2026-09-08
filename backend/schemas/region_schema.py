from pydantic import BaseModel


class RegionCreate(BaseModel):
    name: str
    code: str


class RegionResponse(BaseModel):
    id: int
    name: str
    code: str

    class Config:
        from_attributes = True