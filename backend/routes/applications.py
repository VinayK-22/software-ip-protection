from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from database import get_db
from models.application import Application
from schemas.application_schema import ApplicationCreate, ApplicationResponse


router = APIRouter(
    prefix="/applications",
    tags=["Applications"]
)


@router.post("/", response_model=ApplicationResponse)
def create_application(
    application: ApplicationCreate,
    db: Session = Depends(get_db)
):
    new_application = Application(
        user_id=application.user_id,
        application_name=application.application_name,
        description=application.description
    )

    db.add(new_application)
    db.commit()
    db.refresh(new_application)

    return new_application


@router.get("/", response_model=list[ApplicationResponse])
def get_applications(db: Session = Depends(get_db)):
    return db.query(Application).all()  