#!/bin/bash
set -e

# Variables
EXECUTOR=$1
MOTIU=$2

# Mensaje del commit
COMMIT_MESSAGE="Pipeline executada per ${EXECUTOR}. Motiu: ${MOTIU}"


# Agregar cambios reales y hacer commit
echo "Agregando cambios y haciendo commit..."
git add README.md
git commit -m "$COMMIT_MESSAGE" || echo "No hay cambios reales para commitear"

# Hacer push
echo "Haciendo push de los cambios..."
git push origin ci_jenkins --force || { echo "Error al hacer push, verifica conflictos"; exit 1; }