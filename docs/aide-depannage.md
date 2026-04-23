# Aide dépannage

## Erreur : `vault: command not found`
Vault n'est pas installé ou n'est pas dans le PATH.

## Erreur d'authentification
Vérifier `VAULT_ADDR` et `VAULT_TOKEN`.

## Erreur sur le moteur `myapp/`
Le moteur de secrets n'est pas activé ; relancer `scripts/init-secrets.sh`.
