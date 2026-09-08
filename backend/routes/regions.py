from fastapi import APIRouter

router = APIRouter(
    prefix="/regions",
    tags=["Regions"]
)


@router.get("/")
def get_regions():
    return {
        "message": "Regions endpoint is working",
        "regions": [
            "India",
            "United States",
            "European Union"
        ]
    }