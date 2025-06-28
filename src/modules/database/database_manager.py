# pylint: disable=C0114

from typing import Any, List, Tuple, Optional  # pylint: disable=C0411
from .idatabase_connection import IDatabaseConnection
from ..singleton import Singleton  # pylint: disable=C0411
import pandas as pd  # pylint: disable=C0411

class DatabaseManager(metaclass=Singleton):
    """
    DatabaseManager provides a high-level interface for performing CRUD 
    (Create, Read, Update, Delete) operations
    on a database using a provided database connection.
    Args:
        connection (IDatabaseConnection): An object implementing the database connection interface.
    Methods:
        create(query: str, params: Tuple[Any, ...]) -> None:
            Executes an INSERT or similar query with the given parameters and commits 
            the transaction. Rolls back the transaction if an exception occurs.
        create_batch(query: str, params: List[Tuple[Any, ...]]) -> None:
            Executes multiple INSERT queries with the given parameters list and commits 
            the transaction. Rolls back the transaction if an exception occurs.
        read(query: str, params: Optional[Tuple[Any, ...]] = None) -> List[Tuple[Any, ...]]:
            Executes a SELECT query with the given parameters and returns the fetched results 
            as a list of tuples.
        read_df(query: str, params: Optional[Tuple[Any, ...]] = None) -> pd.DataFrame:
            Executes a SELECT query with the given parameters and returns the fetched results 
            as a pandas DataFrame with proper column names.
        read_to_dataframe(query: str, params: Optional[Tuple[Any, ...]] = None) -> pd.DataFrame:
            Alias for read_df method for better clarity.
        update(query: str, params: Tuple[Any, ...]) -> None:
            Executes an UPDATE query with the given parameters and commits the transaction.
            Rolls back the transaction if an exception occurs.
        delete(query: str, params: Tuple[Any, ...]) -> None:
            Executes a DELETE query with the given parameters and commits the transaction.
            Rolls back the transaction if an exception occurs.
        execute_raw(query: str, params: Optional[Tuple[Any, ...]] = None) -> None:
            Executes a raw SQL query with the given parameters and commits the transaction.
    """
    def __init__(self, connection: IDatabaseConnection):  # pylint: disable=C0116
        if not isinstance(connection, IDatabaseConnection):
            raise TypeError("connection must implement IDatabaseConnection interface")
        self.connection = connection

    def create(self, query: str, params: Tuple[Any, ...]) -> None:  # pylint: disable=C0116
        try:
            self.connection.execute(query, params)
            self.connection.commit()
        except Exception as e:
            self.connection.rollback()
            raise e

    def create_batch(self, query: str, params: List[Tuple[Any, ...]]) -> None:  # pylint: disable=C0116
        try:
            if isinstance(params, list):
                self.connection.executemany(query, params)
                self.connection.commit()
            else:
                raise ValueError("params should be a list of tuples")
        except Exception as e:
            self.connection.rollback()
            raise e

    def read(self, query: str, params: Optional[Tuple[Any, ...]] = None) -> List[Tuple[Any, ...]]:  # pylint: disable=C0116
        self.connection.execute(query, params)
        return self.connection.fetchall()

    def read_df(self, query: str, params: Optional[Tuple[Any, ...]] = None) -> pd.DataFrame:  # pylint: disable=C0116
        """
        Executes a SELECT query and returns the results as a pandas DataFrame.
        
        Args:
            query (str): The SQL query to execute
            params (Optional[Tuple[Any, ...]]): Optional parameters for the query
            
        Returns:
            pd.DataFrame: Query results as a DataFrame with column names
        """
        self.connection.execute(query, params)
        data = self.connection.fetchall()
        columns = self.connection.get_column_names()
        
        # Fallback to generic column names if no columns are available
        if not columns and data:
            columns = [f"column_{i}" for i in range(len(data[0]))]
        
        return pd.DataFrame(data, columns=columns)

    def read_to_dataframe(self, query: str, params: Optional[Tuple[Any, ...]] = None) -> pd.DataFrame:  # pylint: disable=C0116
        """
        Alias for read_df method for better clarity.
        """
        return self.read_df(query, params)

    def update(self, query: str, params: Tuple[Any, ...]) -> None:  # pylint: disable=C0116
        try:
            self.connection.execute(query, params)
            self.connection.commit()
        except Exception as e:
            self.connection.rollback()
            raise e

    def delete(self, query: str, params: Tuple[Any, ...]) -> None:  # pylint: disable=C0116
        try:
            self.connection.execute(query, params)
            self.connection.commit()
        except Exception as e:
            self.connection.rollback()
            raise e

    def execute_raw(self, query: str, params: Optional[Tuple[Any, ...]] = None) -> None:  # pylint: disable=C0116
        self.connection.execute(query, params)
        self.connection.commit()
