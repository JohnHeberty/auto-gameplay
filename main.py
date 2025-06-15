from flask import Flask, render_template
from modules.auth.controller import auth_bp
from modules.config import config

app = Flask(__name__, template_folder='templates')
app.register_blueprint(auth_bp)

@app.route('/')
def index():
    """
    Renders the login page template.

    Returns:
        str: Rendered HTML of the 'login.html' template.
    """
    return render_template('login/login.html')

@app.route('/cadastro-usuario')
def register_user():
    """
    Renders the login page template.

    Returns:
        str: Rendered HTML of the 'login.html' template.
    """
    return render_template('cadastro/user.html')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=config["APP_PORT"], debug=True)
