#!/bin/bash

# Validació de paràmetres
if [ $# -ne 2 ]; then
  echo "Ús: $0 <PARAM_EXECUTOR> <PARAM_MOTIU>"
  exit 1
fi

PARAM_EXECUTOR=$1
PARAM_MOTIU=$2

# Afegir, commitejar i fer push dels canvis
git add README.md
git commit -m "Pipeline executada per $PARAM_EXECUTOR. Motiu: $PARAM_MOTIU"
git push origin main