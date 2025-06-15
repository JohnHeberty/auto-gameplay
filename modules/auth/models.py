# models.py
# Modelo de usuário simples
class User:
    def __init__(self, username: str, password: str):
        self.username = username
        self.password = password
