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
        self.path_init_table = os.path.join(self.sql_path, 'init', 'table_users.sql')
        self.querys = {}
        self._querys()

    def _querys(self):
        """
        Carrega os arquivos SQL necessários para a autenticação.
        """
        path_folder = os.path.join(self.sql_path, 'users')
        files = os.listdir(path_folder)
        for file in files:
            if file.endswith('.sql'):
                query_name = file.replace('.sql', '')
                path_file = os.path.join(path_folder, file)
                with open(path_file, 'r', encoding='utf-8') as f:
                    self.querys[query_name] = f.read()

    def _ensure_users_table(self):
        """
        Garante que a tabela 'users' exista no banco de dados.
        Se não existir, cria a tabela usando o script SQL localizado em path_init_table.
        """
        # Retorna ao início da transação
        self.db_manager.connection.rollback()
        # Tenta criar a tabela de usuários se não existir
        with open(self.path_init_table, 'r', encoding='utf-8') as f:
            self.db_manager.execute_raw(f.read())

    def authenticate(self, username: str, password: str) -> bool:
        """
        Autentica o usuário consultando o banco de dados.
        """
        try:
            result = self.db_manager.read(self.querys["valid_login"], (username, password))
            return bool(result)
        except UndefinedTable:
            # Se a tabela não existir, tenta criá-la
            self._ensure_users_table()
            # Tenta autenticar novamente após criar a tabela
            result = self.db_manager.read(self.querys["valid_login"], (username, password))
            return bool(result)
        except Exception as e:
            raise RuntimeError(f"Erro ao autenticar usuário: {e}") from e

    def create_user(self, username: str, password: str) -> bool:
        """
        Cria um novo usuário no banco de dados. Retorna True se criado, False se já existe.
        """
        # Verifica se já existe
        if self.db_manager.read(self.querys["check_user"], (username,)):
            return False
        # Cria usuário
        self.db_manager.create(self.querys["inser_user"], (username, password))
        return True
