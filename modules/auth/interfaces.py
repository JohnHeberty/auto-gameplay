# interfaces.py
from abc import ABC, abstractmethod

class IAuthService(ABC):
    """
    Interface for authentication services.
    This abstract base class defines the contract for authentication services,
    requiring the implementation of an `authenticate` method that verifies user credentials.
    Methods:
        authenticate(username: str, password: str) -> bool:
            Returns True if authentication is successful, False otherwise.
    """
    @abstractmethod
    def authenticate(self, username: str, password: str) -> bool:
        """
        Authenticate a user based on the provided username and password.

        Args:
            username (str): The username of the user attempting to authenticate.
            password (str): The password associated with the username.

        Returns:
            bool: True if authentication is successful, False otherwise.
        """
        pass # pylint-disable=W0107
