import os

# Adiciona o diretório raiz do projeto ao sys.path
ROOT_DIR = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

print("ROOT__file__:", __file__)
print("ROOT_DIR:", ROOT_DIR)

os.chdir(ROOT_DIR)

from modules.config import config
from modules import db_manager
import glob

# Caminho para os scripts SQL
SQL_DIR = os.path.join(
    os.path.dirname(os.path.dirname(os.path.dirname(__file__))),
    'constants',
    'querys',
    'init'
)

def run_init_app():
    """
    Initializes the application by connecting to the PostgreSQL database and executing all 
    SQL scripts found in the specified directory.
    Steps performed:
    1. Establishes a connection to the PostgreSQL database using provided credentials.
    2. Initializes the database manager with the established connection.
    3. Finds and sorts all `.sql` files in the configured SQL directory.
    4. For each SQL file:
        - Reads its contents.
        - Splits the script into individual SQL statements using ';' as a delimiter.
        - Executes each non-empty statement using the database manager.
        - Prints the status of each execution.
        - Catches and prints any exceptions that occur during execution.
    5. Closes the database connection after processing all files.
    Raises:
        Exceptions are caught and printed for each SQL statement execution, but not propagated.
    """
    # Executa todos os arquivos .sql da pasta
    sql_files = sorted(
        glob.glob(os.path.join(SQL_DIR, '*.sql')), 
        key=lambda x: os.path.basename(x).split('_')[1].replace('.','')
    )
    for sql_file in sql_files:
        with open(sql_file, 'r', encoding='utf-8') as f:
            sql_script = f.read()
            # Divide por ";" para múltiplos comandos
            for statement in filter(None, map(str.strip, sql_script.split(';'))):
                if statement:
                    try:
                        print(f'Executado: {os.path.basename(sql_file)}')
                        db_manager.execute_raw(statement)
                    except Exception as e:
                        print(f'Erro ao executar {os.path.basename(sql_file)}: {e}')
                        db_manager.connection.rollback()
    db_manager.connection.close()

if __name__ == '__main__':
    run_init_app()
