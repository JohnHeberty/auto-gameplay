FROM apache/airflow:2.9.1-python3.10

# Copie seus DAGs e plugins se desejar
# COPY dags/ /opt/airflow/dags/
# COPY plugins/ /opt/airflow/plugins/

# Instale dependências extras se necessário
# RUN pip install --no-cache-dir <pacotes>