from modules.database.postgres_connection import PostgresConnection
from modules.database.database_manager import DatabaseManager
from modules.config import config

# Instancia conexão real com banco
db_connection = PostgresConnection(
    host=config["DB_HOST"],
    database=config["DB_NAME"],
    user=config["DB_USER"],
    password=config["DB_PASSWORD"],
    port=config["DB_PORT"]
)
db_connection.connect()
db_manager = DatabaseManager(db_connection)
