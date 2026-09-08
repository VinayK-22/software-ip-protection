from fastapi import APIRouter

router = APIRouter(
    prefix="/ip-types",
    tags=["IP Types"]
)


@router.get("/")
def get_ip_types():
    return {
        "message": "IP types endpoint is working",
        "ip_types": [
            "Copyright",
            "Patent",
            "Trademark",
            "Trade Secret"
        ]
    }
