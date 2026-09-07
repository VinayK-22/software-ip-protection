from fastapi import FastAPI

from config import APP_NAME, APP_VERSION


# Create the FastAPI application
app = FastAPI(
    title=APP_NAME,
    version=APP_VERSION
)


# Root endpoint
@app.get("/")
def root():
    return {
        "message": "Software IP Protection System API is running",
        "version": APP_VERSION
    }