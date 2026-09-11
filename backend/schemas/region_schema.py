from pydantic import BaseModel
from typing import Optional


class RegionCreate(BaseModel):
    region_name: str
    country_code: Optional[str] = None


class RegionResponse(BaseModel):
    region_id: int
    region_name: str
    country_code: Optional[str]
    created_at: str

    class Config:
        from_attributes = True