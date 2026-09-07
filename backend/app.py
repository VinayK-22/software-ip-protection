from fastapi import FastAPI

from config import APP_NAME, APP_VERSION
from database import Base, engine
from models import User, Application, Region, IPType, Requirement, Assessment
from routes.users import router as users_router


Base.metadata.create_all(bind=engine)


app = FastAPI(
    title=APP_NAME,
    version=APP_VERSION
)

app.include_router(users_router)