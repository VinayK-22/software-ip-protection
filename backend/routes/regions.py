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
    region_data: RegionCreate,
    db: Session = Depends(get_db)
):
    region = Region(
        name=region_data.name
    )

    db.add(region)
    db.commit()
    db.refresh(region)

    return region


@router.get("/", response_model=list[RegionResponse])
def read_regions(db: Session = Depends(get_db)):
    return db.query(Region).all()


@router.get("/{region_id}", response_model=RegionResponse)
def read_region(
    region_id: int,
    db: Session = Depends(get_db)
):
    region = db.query(Region).filter(
        Region.id == region_id
    ).first()

    if not region:
        raise HTTPException(
            status_code=404,
            detail="Region not found"
        )

    return region