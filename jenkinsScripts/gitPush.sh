#!/bin/bash

# Cambiar a la rama específica
git checkout ci_jenkins || echo "No se encuentra la rama"

# Confirmar y subir los cambios
git add README.md
git commit -m "Pipeline ejecutada por ${1}. Motivo: ${2}" || echo "Nada que commitear"
git push -u origin ci_jenkins