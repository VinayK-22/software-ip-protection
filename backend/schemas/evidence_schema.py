from pydantic import BaseModel


class EvidenceCreate(BaseModel):
    application_id: int
    requirement_id: int | None = None
    file_name: str
    file_path: str
    document_type: str | None = None
    description: str | None = None


class EvidenceResponse(BaseModel):
    evidence_id: int
    application_id: int
    requirement_id: int | None
    file_name: str
    file_path: str
    document_type: str | None
    description: str | None
    uploaded_at: str

    class Config:
        from_attributes = True