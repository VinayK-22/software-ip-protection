from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from database import get_db
from schemas.requirement_schema import (
    RequirementCreate,
    RequirementResponse
)
from services.requirement_service import (
    create_requirement,
    get_requirement,
    get_requirements,
    get_requirements_by_region,
    get_requirements_by_ip_type
)


router = APIRouter(
    prefix="/requirements",
    tags=["Requirements"]
)


@router.post("/", response_model=RequirementResponse)
def create_new_requirement(
    requirement_data: RequirementCreate,
    db: Session = Depends(get_db)
):
    return create_requirement(db, requirement_data)


@router.get("/", response_model=list[RequirementResponse])
def read_requirements(db: Session = Depends(get_db)):
    return get_requirements(db)


@router.get(
    "/region/{region_id}",
    response_model=list[RequirementResponse]
)
def read_requirements_by_region(
    region_id: int,
    db: Session = Depends(get_db)
):
    return get_requirements_by_region(db, region_id)


@router.get(
    "/ip-type/{ip_type_id}",
    response_model=list[RequirementResponse]
)
def read_requirements_by_ip_type(
    ip_type_id: int,
    db: Session = Depends(get_db)
):
    return get_requirements_by_ip_type(db, ip_type_id)


@router.get(
    "/{requirement_id}",
    response_model=RequirementResponse
)
def read_requirement(
    requirement_id: int,
    db: Session = Depends(get_db)
):
    requirement = get_requirement(db, requirement_id)

    if not requirement:
        raise HTTPException(
            status_code=404,
            detail="Requirement not found"
        )

    return requirement