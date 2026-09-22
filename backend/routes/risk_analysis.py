from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from database import get_db
from services.risk_analysis_service import get_risk_analysis


router = APIRouter(
    prefix="/risk-analysis",
    tags=["Risk Analysis"]
)


@router.get("/{application_id}")
def read_risk_analysis(
    application_id: int,
    db: Session = Depends(get_db)
):
    return get_risk_analysis(db, application_id)