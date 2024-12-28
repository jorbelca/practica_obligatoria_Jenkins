#!/bin/bash
set -e

# Variables
EXECUTOR=$1
MOTIU=$2

# Mensaje del commit
COMMIT_MESSAGE="Pipeline executada per ${EXECUTOR}. Motiu: ${MOTIU}"

# Ejecutar los comandos de Git
git add README.md
git commit -m "$COMMIT_MESSAGE" || echo "No hay cambios para commitear"
git push origin ci_jenkins || echo "Error al hacer push, verifica conflictos"