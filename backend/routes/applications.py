from datetime import datetime

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from database import get_db
from models.application import Application
from schemas.application_schema import (
    ApplicationCreate,
    ApplicationResponse
)


router = APIRouter(
    prefix="/applications",
    tags=["Applications"]
)


@router.post("/", response_model=ApplicationResponse)
def create_application(
    application_data: ApplicationCreate,
    db: Session = Depends(get_db)
):
    current_time = datetime.utcnow().isoformat()

    application = Application(
        user_id=application_data.user_id,
        application_name=application_data.application_name,
        description=application_data.description,
        status="draft",
        created_at=current_time,
        updated_at=current_time
    )

    db.add(application)
    db.commit()
    db.refresh(application)

    return application


@router.get("/", response_model=list[ApplicationResponse])
def get_applications(
    db: Session = Depends(get_db)
):
    return db.query(Application).all()


@router.get(
    "/{application_id}",
    response_model=ApplicationResponse
)
def get_application(
    application_id: int,
    db: Session = Depends(get_db)
):
    application = db.query(Application).filter(
        Application.application_id == application_id
    ).first()

    if not application:
        raise HTTPException(
            status_code=404,
            detail="Application not found"
        )

    return application