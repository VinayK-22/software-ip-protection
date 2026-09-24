from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from database import get_db
from schemas.application_region_schema import (
    ApplicationRegionCreate,
    ApplicationRegionResponse
)
from services.application_region_service import (
    create_application_region,
    get_application_regions,
    get_application_regions_by_application
)


router = APIRouter(
    prefix="/application-regions",
    tags=["Application Regions"]
)


@router.post(
    "/",
    response_model=ApplicationRegionResponse
)
def create_new_application_region(
    application_region_data: ApplicationRegionCreate,
    db: Session = Depends(get_db)
):
    return create_application_region(
        db,
        application_region_data
    )


@router.get(
    "/",
    response_model=list[ApplicationRegionResponse]
)
def read_application_regions(
    db: Session = Depends(get_db)
):
    return get_application_regions(db)


@router.get(
    "/application/{application_id}",
    response_model=list[ApplicationRegionResponse]
)
def read_application_regions_by_application(
    application_id: int,
    db: Session = Depends(get_db)
):
    return get_application_regions_by_application(
        db,
        application_id
    )