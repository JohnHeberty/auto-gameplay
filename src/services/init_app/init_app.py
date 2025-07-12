import os
import glob
import sys
import psycopg2
from dotenv import load_dotenv

# Carrega as variáveis do arquivo .env
load_dotenv()

# Configuração do banco
DB_CONFIG = {
    "host": os.getenv("DB_HOST", "localhost"),
    "port": int(os.getenv("DB_PORT", "5432")),
    "user": os.getenv("DB_USER", "usergameplay"),
    "password": os.getenv("DB_PASSWORD", "gameplay123"),
    "database": os.getenv("DB_NAME", "autogameplay")
}

# Adiciona o diretório raiz do projeto ao sys.path
ROOT_DIR = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

print(f'ROOT__file__: {__file__}')
print(f'ROOT_DIR: {ROOT_DIR}')

# Caminho para os scripts SQL
SQL_DIR_CREATE = os.path.join(ROOT_DIR, 'repository', 'querys', 'init', 'create')
SQL_DIR_INSERT = os.path.join(ROOT_DIR, 'repository', 'querys', 'init', 'insert')

def run_init_app():
    """
    Initializes the application by connecting to the PostgreSQL database and executing all 
    SQL scripts found in the specified directory.
    """
    print(f'SQL_DIR_CREATE: {SQL_DIR_CREATE}')
    print(f'SQL_DIR_INSERT: {SQL_DIR_INSERT}')
    print(f'CREATE exists: {os.path.exists(SQL_DIR_CREATE)}')
    print(f'INSERT exists: {os.path.exists(SQL_DIR_INSERT)}')
    
    # Conecta ao banco de dados
    try:
        conn = psycopg2.connect(**DB_CONFIG)
        conn.autocommit = True
        cur = conn.cursor()
        print('✅ Conexão com banco de dados estabelecida')
    except Exception as e:  # pylint: disable=broad-except
        print(f'❌ Erro ao conectar com banco de dados: {str(e)[:200]}')
        return
    
    for sql_path in [SQL_DIR_CREATE, SQL_DIR_INSERT]:
        if not os.path.exists(sql_path):
            print(f'Diretório não encontrado: {sql_path}')
            continue
            
        print(f'\n=== Processando diretório: {os.path.basename(sql_path)} ===')
        
        # Executa todos os arquivos .sql da pasta
        # Ordena por nome completo para manter ordem natural: table_1, table_1.1, table_1.2, table_2, etc.
        sql_files = sorted(glob.glob(os.path.join(sql_path, '*.sql')), key=lambda x: os.path.basename(x).split("_")[1])
        
        print(f'Encontrados {len(sql_files)} arquivos SQL')
        
        for sql_file in sql_files:
            if not os.path.isfile(sql_file):
                print(f'Arquivo não encontrado: {sql_file}')
                continue
            
            try:
                with open(sql_file, 'r', encoding='utf-8') as f:
                    sql_script = f.read().strip()
                    
                # Verifica se o arquivo não está vazio
                if not sql_script:
                    print(f'📄 Arquivo vazio ignorado: {os.path.basename(sql_file)}')
                    continue
                
                print(f'🔄 Executando: {os.path.basename(sql_file)}')
                
                # Remove comentários de linha única que podem causar problemas
                lines = sql_script.split('\n')
                cleaned_lines = []
                
                for line in lines:
                    stripped = line.strip()
                    # Remove apenas comentários isolados, preserva o resto
                    if stripped and not stripped.startswith('--'):
                        cleaned_lines.append(line)
                    elif not stripped:
                        cleaned_lines.append('')
                
                if not any(line.strip() and not line.strip().startswith('--') for line in cleaned_lines):
                    print(f'📄 Arquivo só com comentários ignorado: {os.path.basename(sql_file)}')
                    continue
                
                clean_sql = '\n'.join(cleaned_lines).strip()
                
                # Execute usando psycopg2
                try:
                    cur.execute(clean_sql)
                    print(f'✅ Sucesso: {os.path.basename(sql_file)}')
                except Exception:  # pylint: disable=broad-except
                    # Se a execução única falhar, tenta dividir por statements
                    print(f'⚠️ Tentando execução por statements: {os.path.basename(sql_file)}')
                    
                    # Divide por ponto e vírgula
                    statements = []
                    current_statement = []
                    
                    for line in clean_sql.split('\n'):
                        current_statement.append(line)
                        if line.strip().endswith(';'):
                            stmt = '\n'.join(current_statement).strip()
                            if stmt:
                                statements.append(stmt)
                            current_statement = []
                    
                    # Adiciona statement restante se houver
                    if current_statement:
                        stmt = '\n'.join(current_statement).strip()
                        if stmt and not stmt.isspace():
                            statements.append(stmt)
                    
                    # Executa cada statement separadamente
                    success_count = 0
                    for i, stmt in enumerate(statements):
                        if stmt.strip():
                            try:
                                cur.execute(stmt)
                                success_count += 1
                            except Exception as stmt_error:  # pylint: disable=broad-except
                                print(f'   ❌ Erro no statement {i+1}: {str(stmt_error)[:100]}')
                    
                    if success_count > 0:
                        print(f'✅ Concluído {success_count}/{len(statements)} statements: {os.path.basename(sql_file)}')
                    else:
                        print(f'❌ Falhou completamente: {os.path.basename(sql_file)}')
                
            except Exception as e:  # pylint: disable=broad-except
                print(f'❌ Erro ao processar {os.path.basename(sql_file)}: {str(e)[:200]}')
                continue
                
    print('\n=== Finalizando conexão com banco de dados ===')
    try:
        cur.close()
        conn.close()
        print('✅ Conexão finalizada')
    except Exception:  # pylint: disable=broad-except
        pass

if __name__ == '__main__':
    run_init_app()
