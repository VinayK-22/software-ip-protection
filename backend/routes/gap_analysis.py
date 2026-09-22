from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from database import get_db
from services.gap_analysis_service import get_gap_analysis


router = APIRouter(
    prefix="/gap-analysis",
    tags=["Gap Analysis"]
)


@router.get("/{application_id}")
def read_gap_analysis(
    application_id: int,
    db: Session = Depends(get_db)
):
    return get_gap_analysis(db, application_id)