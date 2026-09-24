from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from routes.users import router as user_router
from routes.applications import router as application_router
from routes.requirements import router as requirement_router
from routes.assessment import router as assessment_router
from routes.gap_analysis import router as gap_analysis_router
from routes.risk_analysis import router as risk_analysis_router
from routes.evidence import router as evidence_router
from routes.application_region import router as application_region_router
from routes.regions import router as region_router
from routes.ip_types import router as ip_type_router


app = FastAPI(
    title="Software IP Protection API"
)


app.add_middleware(
    CORSMiddleware,
    allow_origins=[
        "http://localhost:5173",
        "http://127.0.0.1:5173"
    ],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


app.include_router(user_router)
app.include_router(application_router)
app.include_router(requirement_router)
app.include_router(assessment_router)
app.include_router(gap_analysis_router)
app.include_router(risk_analysis_router)
app.include_router(evidence_router)
app.include_router(application_region_router)
app.include_router(region_router)
app.include_router(ip_type_router)


@app.get("/")
def root():
    return {
        "message": "Software IP Protection API is running"
    }