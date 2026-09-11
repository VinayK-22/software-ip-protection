from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from database import get_db
from models.region import Region
from schemas.region_schema import RegionCreate, RegionResponse


router = APIRouter(
    prefix="/regions",
    tags=["Regions"]
)


@router.post("/", response_model=RegionResponse)
def create_region(
    region: RegionCreate,
    db: Session = Depends(get_db)
):
    existing_region = db.query(Region).filter(
        Region.region_name == region.region_name
    ).first()

    if existing_region:
        raise HTTPException(
            status_code=409,
            detail="Region already exists"
        )

    new_region = Region(
        region_name=region.region_name,
        country_code=region.country_code
    )

    db.add(new_region)
    db.commit()
    db.refresh(new_region)

    return new_region


@router.get("/", response_model=list[RegionResponse])
def get_regions(db: Session = Depends(get_db)):
    return db.query(Region).all()