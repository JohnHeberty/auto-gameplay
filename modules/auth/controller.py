# controller.py
from flask import Blueprint, request, jsonify, render_template
from .service import AuthService
from .. import db_manager

# Iniciando Autenticação e Cadastro de Usuários
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
    """
    Handles user registration requests.

    - For GET requests, renders the user registration HTML page.
    - For POST requests (expects JSON), attempts to create a new user with the 
    provided username and password.
        - Returns a success message and HTTP 201 if the user is created.
        - Returns an error message and HTTP 409 if the user already exists.
        - Returns an error message and HTTP 400 if username or password is missing.
        - Returns an error message and HTTP 500 for unexpected exceptions.

    Returns:
        Flask Response: Rendered HTML template or JSON response with success/error message.
    """
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
