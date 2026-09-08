from fastapi import APIRouter

router = APIRouter(
    prefix="/requirements",
    tags=["Requirements"]
)


@router.get("/")
def get_requirements():
    return {
        "message": "Requirements endpoint is working",
        "requirements": []
    }
