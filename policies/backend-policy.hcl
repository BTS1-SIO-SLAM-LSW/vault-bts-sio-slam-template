# Lecture des credentials de la base
path "myapp/data/database" {
  capabilities = ["read"]
}

# Lecture des clés API nécessaires au backend
path "myapp/data/api_keys" {
  capabilities = ["read"]
}

# Refus explicite du reste du moteur 'secret'
path "secret/*" {
  capabilities = ["deny"]
}
