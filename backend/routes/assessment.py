from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from database import get_db
from schemas.assessment_schema import (
    AssessmentCreate,
    AssessmentResponse
)
from services.assessment_service import (
    create_assessment,
    get_assessment,
    get_assessments,
    update_assessment
)


router = APIRouter(
    prefix="/assessment",
    tags=["Assessment"]
)


@router.post("/", response_model=AssessmentResponse)
def create_new_assessment(
    assessment_data: AssessmentCreate,
    db: Session = Depends(get_db)
):
    return create_assessment(db, assessment_data)


@router.get("/", response_model=list[AssessmentResponse])
def read_assessments(db: Session = Depends(get_db)):
    return get_assessments(db)


@router.get("/{assessment_id}", response_model=AssessmentResponse)
def read_assessment(
    assessment_id: int,
    db: Session = Depends(get_db)
):
    assessment = get_assessment(db, assessment_id)

    if not assessment:
        raise HTTPException(
            status_code=404,
            detail="Assessment not found"
        )

    return assessment


@router.put("/{assessment_id}", response_model=AssessmentResponse)
def update_existing_assessment(
    assessment_id: int,
    status: str,
    missing_requirements: list[str],
    recommendations: list[str],
    db: Session = Depends(get_db)
):
    assessment = update_assessment(
        db,
        assessment_id,
        status,
        missing_requirements,
        recommendations
    )

    if not assessment:
        raise HTTPException(
            status_code=404,
            detail="Assessment not found"
        )

    return assessment