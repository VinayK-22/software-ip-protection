import os

from fastapi import (
    APIRouter,
    Depends,
    HTTPException,
    UploadFile,
    File,
    Form
)
from fastapi.responses import FileResponse
from sqlalchemy.orm import Session

from database import get_db
from schemas.evidence_schema import (
    EvidenceCreate,
    EvidenceResponse
)
from services.evidence_service import (
    create_evidence,
    get_evidence,
    get_all_evidence,
    get_application_evidence,
    delete_evidence
)


router = APIRouter(
    prefix="/evidence",
    tags=["Evidence"]
)


@router.post("/", response_model=EvidenceResponse)
def create_new_evidence(
    evidence_data: EvidenceCreate,
    db: Session = Depends(get_db)
):
    return create_evidence(db, evidence_data)


@router.post("/upload", response_model=EvidenceResponse)
def upload_evidence(
    application_id: int = Form(...),
    requirement_id: int | None = Form(None),
    document_type: str | None = Form(None),
    description: str | None = Form(None),
    file: UploadFile = File(...),
    db: Session = Depends(get_db)
):
    # Allowed file types
    allowed_extensions = {
        ".pdf",
        ".doc",
        ".docx",
        ".txt",
        ".png",
        ".jpg",
        ".jpeg"
    }

    # Get file extension
    file_extension = os.path.splitext(file.filename)[1].lower()

    # Validate file type
    if file_extension not in allowed_extensions:
        raise HTTPException(
            status_code=400,
            detail="Unsupported file type"
        )

    # Create uploads directory
    upload_directory = os.path.join(
        os.path.dirname(os.path.dirname(__file__)),
        "uploads"
    )

    os.makedirs(upload_directory, exist_ok=True)

    # Create file path
    file_path = os.path.join(
        upload_directory,
        file.filename
    )

    # Save uploaded file
    with open(file_path, "wb") as buffer:
        buffer.write(file.file.read())

    # Create evidence database record
    evidence_data = EvidenceCreate(
        application_id=application_id,
        requirement_id=requirement_id,
        file_name=file.filename,
        file_path=file_path,
        document_type=document_type,
        description=description
    )

    return create_evidence(db, evidence_data)


@router.get("/", response_model=list[EvidenceResponse])
def read_all_evidence(
    db: Session = Depends(get_db)
):
    return get_all_evidence(db)


@router.get(
    "/application/{application_id}",
    response_model=list[EvidenceResponse]
)
def read_application_evidence(
    application_id: int,
    db: Session = Depends(get_db)
):
    return get_application_evidence(db, application_id)


@router.get("/{evidence_id}/download")
def download_evidence(
    evidence_id: int,
    db: Session = Depends(get_db)
):
    evidence = get_evidence(db, evidence_id)

    if not evidence:
        raise HTTPException(
            status_code=404,
            detail="Evidence not found"
        )

    if not os.path.exists(evidence.file_path):
        raise HTTPException(
            status_code=404,
            detail="Evidence file not found"
        )

    return FileResponse(
        path=evidence.file_path,
        filename=evidence.file_name
    )


@router.get(
    "/{evidence_id}",
    response_model=EvidenceResponse
)
def read_evidence(
    evidence_id: int,
    db: Session = Depends(get_db)
):
    evidence = get_evidence(db, evidence_id)

    if not evidence:
        raise HTTPException(
            status_code=404,
            detail="Evidence not found"
        )

    return evidence


@router.delete("/{evidence_id}")
def remove_evidence(
    evidence_id: int,
    db: Session = Depends(get_db)
):
    evidence = delete_evidence(db, evidence_id)

    if not evidence:
        raise HTTPException(
            status_code=404,
            detail="Evidence not found"
        )

    return {
        "message": "Evidence deleted successfully"
    }