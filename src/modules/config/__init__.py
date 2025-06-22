# pylint: disable=C0114

from dotenv import load_dotenv # pylint: disable=E0401
import os # pylint: disable=C0411

# Carrega as variáveis do arquivo .env
load_dotenv()

config = {
    "DB_HOST":          os.getenv("DB_HOST",        "localhost"),
    "DB_PORT":          int(os.getenv("DB_PORT",    "5432")),
    "DB_USER":          os.getenv("DB_USER",        "usergameplay"),
    "DB_PASSWORD":      os.getenv("DB_PASSWORD",    "gameplay123"),
    "DB_NAME":          os.getenv("DB_NAME",        "autogameplay"),
    "APP_PORT":         int(os.getenv("APP_PORT",   "8000"))
}

youtube = {
    "API_KEY":          os.getenv("YOUTUBE_API_KEY", ""),
    "CLIENT_SECRET":    os.getenv("CLIENT_SECRET", "")
}