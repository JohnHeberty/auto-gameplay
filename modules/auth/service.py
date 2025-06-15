# service.py
from .interfaces import IAuthService
from .models import User
from modules.database.database_manager import DatabaseManager
from psycopg2.errors import UndefinedTable
import os

class AuthService(IAuthService):
    """
    AuthService provides authentication functionality by verifying user credentials against a 
    database.
    Methods
    -------
    __init__(db_manager: DatabaseManager)
        Initializes the AuthService with a database manager instance.
    _ensure_users_table()
        Ensures that the 'users' table exists in the database by executing the SQL script 
        located in the constants/querys/table_users.sql file.
    authenticate(username: str, password: str) -> bool
        Authenticates a user by checking the provided username and password against the database.
        If the users table does not exist, it attempts to create it and retries the authentication.
        Returns True if authentication is successful, otherwise False.
    create_user(username: str, password: str) -> bool
        Creates a new user in the database. Returns True if the user is successfully created,
        or False if the user already exists.
    """
    def __init__(self, db_manager: DatabaseManager):
        self.db_manager = db_manager
        self.sql_path = os.path.join(
            os.path.dirname(os.path.dirname(os.path.dirname(__file__))),
            'constants',
            'querys',
        )

    def _ensure_users_table(self):
        with open(os.path.join(self.sql_path,'init','table_users.sql'), 'r', encoding='utf-8') as f:
            self.db_manager.execute_raw(f.read())
            print("Tabela 'users' criada com sucesso.")

    def _query_valid(self):
        with open(os.path.join(self.sql_path,'users','valid.sql'), 'r', encoding='utf-8') as f:
            sql = f.read()
        return sql

    def authenticate(self, username: str, password: str) -> bool:
        """
        Autentica o usuário consultando o banco de dados.
        """
        try:
            result = self.db_manager.read(self._query_valid(), (username, password))
            return bool(result)
        except UndefinedTable:
            self.db_manager.connection.rollback()
            self._ensure_users_table()
            result = self.db_manager.read(self._query_valid(), (username, password))
            return bool(result)
        except Exception as e:
            raise Exception(f"Erro ao autenticar usuário: {e}")

    def create_user(self, username: str, password: str) -> bool:
        """
        Cria um novo usuário no banco de dados. Retorna True se criado, False se já existe.
        """
        # Verifica se já existe
        query_check = "SELECT 1 FROM users WHERE username = %s LIMIT 1"
        if self.db_manager.read(query_check, (username,)):
            return False'
        # Cria usuário
        query_insert = "INSERT INTO users (username, password) VALUES (%s, %s)"
        self.db_manager.create(query_insert, (username, password))
        return True
