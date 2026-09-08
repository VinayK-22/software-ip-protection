from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from database import get_db
from schemas.application_schema import ApplicationCreate, ApplicationResponse
from services.application_service import (
    create_application,
    get_application,
    get_applications
)


router = APIRouter(
    prefix="/applications",
    tags=["Applications"]
)


@router.post("/", response_model=ApplicationResponse)
def create_new_application(
    application_data: ApplicationCreate,
    db: Session = Depends(get_db)
):
    return create_application(db, application_data)


@router.get("/", response_model=list[ApplicationResponse])
def read_applications(db: Session = Depends(get_db)):
    return get_applications(db)


@router.get("/{application_id}", response_model=ApplicationResponse)
def read_application(
    application_id: int,
    db: Session = Depends(get_db)
):
    application = get_application(db, application_id)

    if not application:
        raise HTTPException(
            status_code=404,
            detail="Application not found"
        )

    return application