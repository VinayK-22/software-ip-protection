from pydantic import BaseModel


class ApplicationRegionCreate(BaseModel):
    application_id: int
    region_id: int


class ApplicationRegionResponse(BaseModel):
    application_id: int
    region_id: int

    class Config:
        from_attributes = True