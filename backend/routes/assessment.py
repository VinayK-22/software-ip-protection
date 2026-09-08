from fastapi import APIRouter

router = APIRouter(
    prefix="/assessment",
    tags=["Assessment"]
)


@router.get("/")
def get_assessment():
    return {
        "message": "Assessment endpoint is working",
        "assessment": {
            "status": "Not started",
            "missing_requirements": [],
            "recommendations": []
        }
    }