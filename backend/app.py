from fastapi import FastAPI

from config import APP_NAME, APP_VERSION

from database import Base, engine

from models import (
    User,
    Application,
    Region,
    IPType,
    Requirement,
    Assessment
)

from routes.users import router as users_router
from routes.applications import router as applications_router
from routes.regions import router as regions_router
from routes.ip_types import router as ip_types_router
from routes.requirements import router as requirements_router
from routes.assessment import router as assessment_router


Base.metadata.create_all(bind=engine)


app = FastAPI(
    title=APP_NAME,
    version=APP_VERSION
)


app.include_router(users_router)
app.include_router(applications_router)
app.include_router(regions_router)
app.include_router(ip_types_router)
app.include_router(requirements_router)
app.include_router(assessment_router)