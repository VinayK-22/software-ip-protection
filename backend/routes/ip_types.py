from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from database import get_db
from models.ip_type import IPType
from schemas.ip_type_schema import IPTypeCreate, IPTypeResponse


router = APIRouter(
    prefix="/ip-types",
    tags=["IP Types"]
)


@router.get("/", response_model=list[IPTypeResponse])
def get_ip_types(db: Session = Depends(get_db)):
    return db.query(IPType).all()


@router.post("/", response_model=IPTypeResponse)
def create_ip_type(
    ip_type: IPTypeCreate,
    db: Session = Depends(get_db)
):
    new_ip_type = IPType(
        ip_type_name=ip_type.ip_type_name,
        description=ip_type.description
    )

    db.add(new_ip_type)
    db.commit()
    db.refresh(new_ip_type)

    return new_ip_type