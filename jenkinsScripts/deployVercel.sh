#!/bin/bash

# Comprovar si el token de Vercel està configurat
if [ -z "$VERCEL_TOKEN" ]; then
  echo "Error: VERCEL_TOKEN no està configurat."
  exit 1
fi

# Executar el desplegament
vercel --token $VERCEL_TOKEN --prod --confirm --cwd ./build