from dotenv import load_dotenv
from os import environ
from pyodbc import connect, OperationalError
from subprocess import run, CalledProcessError
from time import sleep

def connect_db() -> None:
    """
    """

    if load_dotenv():
        server = environ.get("SERVER")
        username = environ.get("USERNAME")
        password = environ.get("DB_PASSWORD")
        connection_string = f"DRIVER={{ODBC Driver 18 for SQL Server}};SERVER={server};UID={username};PWD={password};Encrypt=no"
        
        try:
            initial_container_status = run(["docker", "ps"], check=True, capture_output=True).stdout.decode("utf-8").replace("\n", "")
            container_status = ""
            if not initial_container_status.endswith("sql50"):
                run(["docker", "compose", "-f", "./compose.yaml", "up", "-d"], check=True)
                print("Waiting for database connection")
                sleep(10)
                container_status = run(["docker", "ps"], check=True, capture_output=True).stdout.decode("utf-8").replace("\n", "")
            else:
                container_status = initial_container_status
        except CalledProcessError as ce:
            print(f"{ce.cmd} failed")
            return
        else:
            if container_status.endswith("sql50"):
                try:
                    db_connection = connect(connection_string)
                    cursor = db_connection.cursor()
                except OperationalError as oe:
                    print("Database connection failed")
                    print(f"Failure reason -> {oe}")
                    return
                else:
                    db_connection.autocommit=True
                    with open("./create_databases.sql", "r") as ddl:
                        ddl_script = ddl.read()
                        cursor.execute(ddl_script)
                    db_connection.autocommit=False
                    print("Databases created successfully")
                    cursor.close()
                    db_connection.close()

if __name__ == "__main__":
    connect_db()

