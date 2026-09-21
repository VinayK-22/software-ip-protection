from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from database import get_db
from models.requirement import Requirement
from schemas.requirement_schema import (
    RequirementCreate,
    RequirementUpdate,
    RequirementResponse
)


router = APIRouter(
    prefix="/requirements",
    tags=["Requirements"]
)


@router.get("/", response_model=list[RequirementResponse])
def get_requirements(db: Session = Depends(get_db)):
    return db.query(Requirement).all()


@router.get("/{requirement_id}", response_model=RequirementResponse)
def get_requirement(
    requirement_id: int,
    db: Session = Depends(get_db)
):
    requirement = db.query(Requirement).filter(
        Requirement.requirement_id == requirement_id
    ).first()

    if requirement is None:
        raise HTTPException(
            status_code=404,
            detail="Requirement not found"
        )

    return requirement


@router.get("/region/{region_id}", response_model=list[RequirementResponse])
def get_requirements_by_region(
    region_id: int,
    db: Session = Depends(get_db)
):
    requirements = db.query(Requirement).filter(
        Requirement.region_id == region_id
    ).all()

    return requirements




@router.post("/", response_model=RequirementResponse)
def create_requirement(
    requirement: RequirementCreate,
    db: Session = Depends(get_db)
):
    new_requirement = Requirement(
        ip_type_id=requirement.ip_type_id,
        region_id=requirement.region_id,
        requirement_title=requirement.requirement_title,
        requirement_description=requirement.requirement_description,
        action_required=requirement.action_required,
        mandatory=requirement.mandatory,
        source_name=requirement.source_name,
        source_url=requirement.source_url
    )

    db.add(new_requirement)
    db.commit()
    db.refresh(new_requirement)

    return new_requirement

@router.delete("/{requirement_id}")
def delete_requirement(
    requirement_id: int,
    db: Session = Depends(get_db)
):
    requirement = db.query(Requirement).filter(
        Requirement.requirement_id == requirement_id
    ).first()

    if requirement is None:
        raise HTTPException(
            status_code=404,
            detail="Requirement not found"
        )

    db.delete(requirement)
    db.commit()

    return {
        "message": "Requirement deleted successfully"
    }
    
@router.put("/{requirement_id}", response_model=RequirementResponse)
def update_requirement(
    requirement_id: int,
    requirement: RequirementUpdate,
    db: Session = Depends(get_db)
):
    existing_requirement = db.query(Requirement).filter(
        Requirement.requirement_id == requirement_id
    ).first()

    if existing_requirement is None:
        raise HTTPException(
            status_code=404,
            detail="Requirement not found"
        )

    existing_requirement.ip_type_id = requirement.ip_type_id
    existing_requirement.region_id = requirement.region_id
    existing_requirement.requirement_title = requirement.requirement_title
    existing_requirement.requirement_description = requirement.requirement_description
    existing_requirement.action_required = requirement.action_required
    existing_requirement.mandatory = requirement.mandatory
    existing_requirement.source_name = requirement.source_name
    existing_requirement.source_url = requirement.source_url

    db.commit()
    db.refresh(existing_requirement)

    return existing_requirement