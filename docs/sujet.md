# Sujet étudiant – HashiCorp Vault

## Contexte professionnel
Vous intervenez dans une PME qui développe une application web Python.
Les développeurs stockaient auparavant les credentials de base de données dans le code source.
Vous devez démontrer une approche plus sûre avec HashiCorp Vault.

## Travail demandé
1. Démarrer Vault en mode développement.
2. Initialiser le moteur de secrets `myapp`.
3. Créer le secret `myapp/database`.
4. Lire le secret via la CLI.
5. Appliquer une policy limitant les accès.
6. Générer un token à durée limitée.
7. Exécuter l'application Python et vérifier qu'elle lit le secret depuis Vault.

## Questions d'analyse
1. Pourquoi le stockage d'un mot de passe en dur dans le code est-il dangereux ?
2. Que signifie le principe du moindre privilège ?
3. Pourquoi un token à durée limitée améliore-t-il la sécurité ?
4. Pourquoi le mode dev n'est-il pas acceptable en production ?
