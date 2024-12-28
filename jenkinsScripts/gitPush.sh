#!/bin/bash
set -e

# Variables
EXECUTOR=$1
MOTIU=$2

# Mensaje del commit
COMMIT_MESSAGE="Pipeline executada per ${EXECUTOR}. Motiu: ${MOTIU}"

# Actualizar la rama local con el remoto
echo "Actualizando la rama local con el remoto..."
git pull origin ci_jenkins --rebase || { echo "Error durante git pull --rebase"; exit 1; }

# Agregar cambios y hacer commit
echo "Agregando cambios y haciendo commit..."
git add README.md
git commit -m "$COMMIT_MESSAGE" || echo "No hay cambios para commitear"

# Hacer push
echo "Haciendo push de los cambios..."
git push origin ci_jenkins || { echo "Error al hacer push, verifica conflictos"; exit 1; }