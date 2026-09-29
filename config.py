import os
from dotenv import load_dotenv

load_dotenv()


class Config:
    SECRET_KEY = os.getenv(
        "FLASK_SECRET_KEY",
        "change-this-secret"
    )

    DATABASE_PATH = os.getenv(
        "DATABASE_PATH",
        "database/credit_debt.db"
    )

    DEBUG = os.getenv(
        "DEBUG",
        "true"
    ).lower() == "true"