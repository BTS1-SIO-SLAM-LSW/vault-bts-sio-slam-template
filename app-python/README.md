# Application Python de démonstration

Cette mini application simule un backend qui lit ses credentials BDD depuis Vault.

## Lancement

```bash
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
python app.py
```

## Ce qu'il faut observer
- aucun mot de passe en dur dans le code ;
- lecture du secret via l'API Vault ;
- affichage masqué du mot de passe.
