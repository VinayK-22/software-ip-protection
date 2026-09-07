import os
from dotenv import load_dotenv

# Load environment variables from the .env file
load_dotenv()

# Application information
APP_NAME = "Software IP Protection System"
APP_VERSION = "1.0.0"

# Database configuration
# If DATABASE_URL is not provided, SQLite will be used.
DATABASE_URL = os.getenv(
    "DATABASE_URL",
    "sqlite:///./ip_protection.db"
)