from pydantic import BaseModel


class AssessmentCreate(BaseModel):
    application_id: int
    requirement_id: int
    status: str = "pending"
    is_compliant: bool = False
    notes: str | None = None


class AssessmentUpdate(BaseModel):
    status: str
    is_compliant: bool
    notes: str | None = None


class AssessmentResponse(BaseModel):
    id: int
    application_id: int
    requirement_id: int
    status: str
    is_compliant: bool
    notes: str | None

    class Config:
        from_attributes = True