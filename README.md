# Jenkins

## Teoria

## Práctica

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
Aquesta pipeline:

- Tindrá com a agent, any.
- Tools, utilitzará node 20.
  (El plugin que fa us de node y permiteix fer us de les diferents versions l'havia descarregat i configurat globalment en les práctiques anteriors)
- Almacenará les dades que se li passen per input del UI de Jenkins com a parametres.(Les caracteristiques d' aquests parametres es veuen clarament en les captures)
- Hem creat una stage que mostre per consola els valors dels inputs aportats, per a comprovar que tot funciona correctamet.

![](capturas/dades/stages.png)

Captura config de node global:

![](capturas/dades/node.png)

Seguidament, creem una "Nueva Tarea" en Jenkins del tipus Pipeline.

![](capturas/dades/tarea.png)

Aquesta pipeline deu de configurarse. Hem de configurar la pipeline per a que utilitze el codi del repo de github. `Pipeline > Pipeline script from SCM > Github `. Afegim la url, la rama i les credencials que tenen el token. (Pareix que done error, pero es que el token era de tipus 'fine-grained' i només estava configurat per al repo de les práctiques de 'prova')

![](capturas/dades/pipe.png)

En aquest cas, fa us d' un repo de github. Per a conseguir el codi del repo precisará d'un token (que ja tenia configurat com a secret global de les practiques anteriors).

![](capturas/dades/github_token.png)
![](capturas/dades/gh_token.png)

També, aquest pipeline deu ser configurat perque requerisca al usuari els tres parametres que haviem declarat en el Jenkinsfile. En `Esta ejecucion debe parametrizarse`, creem tres parametre de cadena y els asignem el mateix nom que tenen en el Jenkinsfile. (Les altres variables encara que no les fiquem, Jenkins les agafa de la declaració del Jenkinsfile)

![](capturas/dades/param_config.png)

![](capturas/dades/tarea.png)

Finalment, fem el commit i dins de `Jenkins > Tarea > Build with Parameters`, per tal de que comence a executar la pipeline. Al començar, es pausará per a demanar els parametres per pantalla. Una vegada introduits, la pipeline continuará executanse.
![](capturas/dades/params.png)

Captura del resultat, amb la impresió dels valors per consola.
![](capturas/dades/success.png)

#### Linter

En el meu cas no es precís instalar el plugin de eslint per a react. Ja que remix el du incorporat.
Captura del package.json
![](capturas/linter/package.png)

Creem una primera stage del pipeline que incorpore el codi que ha de fer que s'execute el linter per part del servidor Jenkins. Centrant-se en la stage. Solament te dos comandos:

- Npm install , per aconseguir les dependencies
- Npm run lint, per executar el linter.

![](capturas/linter/stage.png)

Executem el pipeline, en un primer moment:

![](capturas/linter/success.png)

Per a comprovar que `falla` quant ha de ser així, incorporem algunes regles al .eslint:

![](capturas/linter/reglas.png)

Creem una funció que no s'utilitza i que te un error de sintaxi.
![](capturas/linter/fallo.png)

Executem el pipeline, per a comprovar:

![](capturas/linter/run_fallo.png)

#### Test

Instalem jest en el nostre projecte
![](capturas/linter/npm_i.png)

Creem un arxiu jest.config.cjs per a indicar la configuració de jest
![](capturas/test/jest_config.png)

Modifiquem el package.json per a incorporar un nou script per a poder executar jest
![](capturas/test/pkg.png)

Creem un arxiu func.ts en app>helpers que contindrá diverses funcions
![](capturas/test/functions.png)

Creem els tests de Jest en test > math.test.ts
![](capturas/test/tests.png)

Creem una nova stage dins del Jenkinsfile. Per agilizar, s´ha decidit extraure la instalacio de dependencies al principi, per a que totes les stages que ho precisen fagen us d´ells.
![](capturas/test/jenkinsfile.png)

Fem el commit i comprovem en Jenkins
![](capturas/test/ok.png)

Introduim un `fallo` en els tests i comprovem en Jenkins que capture l'errror correctamen
![](capturas/test/fallo.png)
![](capturas/test/wrong.png)

#### Update Readme

Cuando añades returnStatus: true, el pipeline no falla automáticamente si el comando retorna un código de error. En cambio, el comando devuelve el código de salida como un número, que puedes manejar tú mismo. Por ejemplo:
• Si el comando tiene éxito (código de salida 0), la variable status será 0.
• Si falla (código de salida distinto de 0), status contendrá ese valor (por ejemplo, 1, 2, etc.).

#### Push Changes

#### Build

Creem una nova stage dins del Jenkinsfile. Aquesta solament fara us del comando _npm run build_, per a empaquetar el projecte
![](capturas/build/stage.png)

Fem un commit i comprovem en el pipeline de Jenkins
![](capturas/build/ok.png)

#### Deploy Vercel

Comencem creant un token a vercel per a que jenkins tinga permisos per a desplegar
![](capturas/vercel/vercel_token.png)

Guardem el token en una credencial global, per poder utilitzar-la en els pipelines de Jenkins
![](capturas/vercel/credencial.png)

Vinculem el projecte amb vercel, perque cree `.vercel/project.json` amb les caracteristiques del projecte
![](capturas/vercel/link.png)

Arxiu project.json
![](capturas/vercel/vercel_json.png)

Passem al projecte en si, primer creem el arxiu deployVercel.sh dins de /jenkinsScripts amb el seguent contingut:

- Si no se li passa el token de vercel, retorna un error
- En cas contrari, fa el deploy del projecte
  ![](capturas/vercel/script.png)

Canviem permisos del arxiu que conté el script, per a la maquina de Jenkins
![](capturas/vercel/chmod.png)

Creem una nova stage dins del jenkinsFile.

- S'executa si totes les demes stages han acabat be (succesfull)
- Primer instala el cli de vercel en la máquina de Jenkins
- Despres executa el script anteriorment creat amb el token de Vercel com a credencial global
  ![](capturas/vercel/stage.png)

Fem el commit i comprovem els logs del pipeline
![](capturas/vercel/ok.png)

Finalment, naveguem al deploy (url mes amigable que es troba en el dashboard)
![](capturas/vercel/deploy.png)

#### Notificació

### RESULTADO DE LOS ÚLTIMOS TESTS

<!---Start place for the badge -->

<!---End place for the badge -->
