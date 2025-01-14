from os import environ
from pathlib import Path
from subprocess import CalledProcessError, run
from time import sleep

from dotenv import load_dotenv
from pyodbc import Connection, OperationalError, connect


def check_container_status(container_name: str) -> bool:
    """
    Helper Function to check the status of running containers and return whether the
    given container is up and running.

    Arguments
    ---------
        container_name (str): Name of the container for which status is to be checked.

    Returns
    -------
        True if the container is already up and running else False
    """
    try:
        container_status = (
            run(["/usr/bin/docker", "ps"], check=True, capture_output=True)
            .stdout.decode("utf-8")
            .replace("\n", "")
        )
    except CalledProcessError as ce:
        print(f"{ce.cmd} failed")
        return False
    else:
        return container_status.endswith(container_name)


def build_container(compose_path: Path = Path("./compose.yaml")) -> None:
    """
    Helper Function to build containers from compose.yaml file.

    Arguments
    ---------
        compose_path (Path): Path object of the compose.yaml file.

    Returns
    -------
        None
    """
    try:
        run(
            [
                "/usr/bin/docker",
                "compose",
                "-f",
                compose_path.absolute().as_posix(),
                "up",
                "-d",
            ],
            check=True,
            capture_output=True,
        )
    except CalledProcessError as ce:
        print(f"{ce.cmd} failed")


def get_connection_string() -> str | None:
    """
    Helper Function to form a connection string from environment variables.

    Arguments
    ---------
        None

    Returns
    -------
        Connection string formed from the loaded environment variables.
    """
    driver = environ.get("DRIVER")
    server = environ.get("SERVER")
    username = environ.get("USERNAME")
    password = environ.get("DB_PASSWORD")
    encryption = environ.get("ENCRYPTION")
    return f"DRIVER={driver};SERVER={server}; \
            UID={username};PWD={password};Encrypt={encryption}"


def create_connection() -> Connection | None:
    """
    Helper Function to create a connection to existing SQL Server database.

    Arguments
    ---------
        None

    Returns
    -------
        Connection object if the connection was successful
        else OperationalError exception is raised.
    """
    try:
        db_connection = connect(get_connection_string())
        print("Database Connected")
    except OperationalError as oe:
        print("Database connection failed.")
        print(oe)
    else:
        return db_connection


def setup_db() -> None:
    """
    Utility Function to setup SQL Server database in a container and perform the
    necessary DDL and DML operations.

    Arguments
    ---------
        None

    Returns
    -------
        None
    """

    if load_dotenv():
        container_name = environ.get("CONTAINER_NAME")

        if container_name and not check_container_status(container_name=container_name):
            build_container(compose_path=Path("./compose.yaml"))
            print("SQL Server container created successfully")
            print("Waiting for Database Connection")
            sleep(10)

        db_connection = create_connection()
        if db_connection:
            cursor = db_connection.cursor()

            # Create Database
            db_connection.autocommit = True
            with Path("./create_databases.sql").open() as ddl:
                ddl_script = ddl.read()
                cursor.execute(ddl_script)
                db_connection.autocommit = False
                print("Databases created successfully")

            cursor.close()
        db_connection.close()


if __name__ == "__main__":
    setup_db()
