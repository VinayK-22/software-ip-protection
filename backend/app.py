from fastapi import FastAPI

from routes.users import router as user_router
from routes.requirements import router as requirement_router
from routes.assessment import router as assessment_router
from routes.gap_analysis import router as gap_analysis_router
from routes.risk_analysis import router as risk_analysis_router
from routes.evidence import router as evidence_router


app = FastAPI(
    title="Software IP Protection API"
)


app.include_router(user_router)
app.include_router(requirement_router)
app.include_router(assessment_router)
app.include_router(gap_analysis_router)
app.include_router(risk_analysis_router)
app.include_router(evidence_router)


@app.get("/")
def root():
    return {"message": "Software IP Protection API is running"}