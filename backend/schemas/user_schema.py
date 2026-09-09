from pydantic import BaseModel, EmailStr


class UserCreate(BaseModel):
    full_name: str
    email: EmailStr
    password_hash: str


class UserResponse(BaseModel):
    user_id: int
    full_name: str
    email: EmailStr
    role: str
    created_at: str

    class Config:
        from_attributes = True