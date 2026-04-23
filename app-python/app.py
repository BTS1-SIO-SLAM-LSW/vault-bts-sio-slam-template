import os
import hvac


def mask(value: str) -> str:
    if not value:
        return "<vide>"
    return value[:3] + "***"


def main() -> None:
    vault_addr = os.environ.get("VAULT_ADDR", "http://127.0.0.1:8200")
    vault_token = os.environ.get("VAULT_TOKEN", "root")

    client = hvac.Client(url=vault_addr, token=vault_token)

    if not client.is_authenticated():
        raise SystemExit("Échec d'authentification auprès de Vault.")

    secret = client.secrets.kv.v2.read_secret_version(
        path="database",
        mount_point="myapp",
    )

    data = secret["data"]["data"]
    username = data.get("username", "")
    password = data.get("password", "")

    print("Connexion applicative simulée")
    print(f"URL Vault        : {vault_addr}")
    print(f"Utilisateur BDD  : {username}")
    print(f"Mot de passe BDD : {mask(password)}")
    print("Connexion OK (simulation).")


if __name__ == "__main__":
    main()
