# Corrigé enseignant – éléments attendus

- Le coffre de secrets doit être initialisé sous le chemin `myapp/`.
- La commande `vault kv get myapp/database` doit retourner au minimum `username` et `password`.
- La policy `backend-policy.hcl` doit limiter la lecture aux chemins utiles à l'application.
- Le token généré doit posséder un TTL de 24 h.
- L'application Python doit récupérer le mot de passe depuis Vault et ne pas le contenir en dur.
