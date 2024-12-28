#!/bin/bash
set -e

# Variables
EXECUTOR=$1
MOTIU=$2

# Mensaje del commit
COMMIT_MESSAGE="Pipeline executada per ${EXECUTOR}. Motiu: ${MOTIU}"

# Verificar si hay cambios sin añadir o commitear
if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "Detectados cambios no añadidos o sin commitear. Realizando commit temporal..."
  git add .
  git commit -m "Commit temporal: Resolviendo cambios antes de pull"
fi

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