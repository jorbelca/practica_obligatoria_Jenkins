#!/bin/bash
set -e

# Variables
EXECUTOR=$1
MOTIU=$2

# Mensaje del commit
COMMIT_MESSAGE="Pipeline executada per ${EXECUTOR}. Motiu: ${MOTIU}"


# Configurar la identidad de Git para el usuario de Jenkins
git config --global user.name "Jenkins CI"
git config --global user.email "jenkins@example.com"
# Verificar si hay un rebase en curso
if [ -d .git/rebase-merge ] || [ -d .git/rebase-apply ]; then
  echo "Detectado un rebase en curso. Abortando rebase anterior..."
  git rebase --abort || echo "No había rebase activo que abortar"
fi

# Verificar si hay cambios no confirmados
if [ -n "$(git status --porcelain)" ]; then
  echo "Hay cambios no confirmados. Realizando commit temporal..."
  git add .
  git commit -m "Commit temporal: Resolviendo cambios antes de pull"
fi

# Asegurarse de estar en la rama correcta (ci_jenkins)
git checkout ci_jenkins || git checkout -b ci_jenkins

# Actualizar la rama local con los cambios remotos
echo "Actualizando la rama local con el remoto..."
git fetch origin
git pull origin ci_jenkins --rebase || { echo "Error durante git pull --rebase"; exit 1; }

# Agregar cambios reales y hacer commit
echo "Agregando cambios y haciendo commit..."
git add README.md
git commit -m "$COMMIT_MESSAGE" || echo "No hay cambios reales para commitear"

# Hacer push
echo "Haciendo push de los cambios..."
git push origin ci_jenkins || { echo "Error al hacer push, verifica conflictos"; exit 1; }