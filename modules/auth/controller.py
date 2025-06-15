# controller.py
from flask import Blueprint, request, jsonify, render_template
from .service import AuthService
from modules.database.database_manager import DatabaseManager
from modules.database.postgres_connection import PostgresConnection
from modules.config import config

# Instancia conexão real com banco
postgres_conn = PostgresConnection(
    host=config["DB_HOST"],
    database=config["DB_NAME"],
    user=config["DB_USER"],
    password=config["DB_PASSWORD"],
    port=config["DB_PORT"]
)
postgres_conn.connect()
db_manager = DatabaseManager(postgres_conn)
auth_service = AuthService(db_manager)

auth_bp = Blueprint('auth', __name__)

@auth_bp.route('/login', methods=['POST'])
def login():
    """
    Handles user login by validating credentials from the request payload.

    Expects a JSON payload with 'username' and 'password' fields. If authentication
    is successful, returns a JSON response indicating success with HTTP 200 status.
    If authentication fails, returns a JSON response indicating failure with HTTP 401 
    status.

    Returns:
        Response: JSON response with 'success' and 'message' fields, and appropriate 
        HTTP status code.
    """
    data = request.json
    username = data.get('username')
    password = data.get('password')
    if auth_service.authenticate(username, password):
        return jsonify({'success': True, 'message': 'Login realizado com sucesso!'}), 200
    return jsonify({'success': False, 'message': 'Usuário ou senha inválidos.'}), 401

@auth_bp.route('/cadastrar-usuario', methods=['GET', 'POST'])
def cadastrar_usuario():
    if request.method == 'GET':
        return render_template('cadastro/user.html')
    data = request.get_json()
    username = data.get('username')
    password = data.get('password')
    if not username or not password:
        return jsonify({'success': False, 'message': 'Usuário e senha são obrigatórios.'}), 400
    try:
        if auth_service.create_user(username, password):
            return jsonify({'success': True, 'message': 'Usuário cadastrado com sucesso!'}), 201
        else:
            return jsonify({'success': False, 'message': 'Usuário já existe.'}), 409
    except Exception as e:
        return jsonify({'success': False, 'message': f'Erro ao cadastrar: {e}'}), 500
