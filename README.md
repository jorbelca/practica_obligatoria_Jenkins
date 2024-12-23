# Jenkins

## Teoria

## Practica

#### Preparar el projecte

Primer que res, creem un repo en github per poder fer un seguiment del treball.

Seguidament, comencem un nou projecte de React, en concret amb Remix.
![](capturas/npx_remix.png)

En asegurem de que funcione correctament, executant-lo en local
![](capturas/run_dev.png)

Iniciem git en local, i el vinculem amb el repo de github.
![](capturas/git_init.png)
![](capturas/commit_1.png)

Creem la nova rama ci_jenkins
![](capturas/nova_rama.png)

#### Instalar plugin

Dins del servidor de Jenkins, en Panel de Control > Administrar Jenkins > Plugins > Available , busquem Build Monitor View e instalem
![](capturas/plugin/buscar.png)

El configurem
![](capturas/plugin/crear_vista.png)

La vista del plugin, quedaria aixi en un primer moment. 
![](capturas/plugin/primera.png)

#### Parametres
Hem de crear una primera stage que demane per pantalla al executar el pipeline: Executor, Motiu, Chat ID
Per aixo creem un arxiu Jenkinsfile a l' arrel del projecte i creem una pipeline.


#### Linter


En el meu cas no es precis instalar el plugin de eslint per a react. Ja que remix el du incorporat. 
Captura del package.json 
![](capturas/linter/package.png)

Creem una primera stage del pipeline que incorpore el codi que ha de fer que s'execute el linter per part del servidor Jenkins


![](capturas/linter/stage.png)

#### Test

#### Build

#### Update Readme

#### Push Changes

#### Deploy Vercel

#### Notificació
