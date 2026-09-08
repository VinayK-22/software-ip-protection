from fastapi import APIRouter

router = APIRouter(
    prefix="/applications",
    tags=["Applications"]
)


@router.get("/")
def get_applications():
    return {
        "message": "Applications endpoint is working",
        "applications": []
    }
