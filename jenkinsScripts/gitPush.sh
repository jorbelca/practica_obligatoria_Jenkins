#!/bin/bash

# Validació de paràmetres
if [ $# -ne 2 ]; then
  echo "Ús: $0 <PARAM_EXECUTOR> <PARAM_MOTIU>"
  exit 1
fi

PARAM_EXECUTOR=$1
PARAM_MOTIU=$2


# Configurar nom y correu
git config --local user.name "$1"
git config --local user.email "jenkins@ci.com"

#descarregar totes les rames i cambiar a la de jenkins
git fetch --all
git checkout ci_jenkins || git checkout -b ci_jenkins

# Afegir, commitejar i fer push dels canvis
git add README.md
git commit -m "Pipeline executada per $PARAM_EXECUTOR. Motiu: $PARAM_MOTIU"
git push origin ci_jenkins