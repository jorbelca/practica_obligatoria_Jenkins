# Jenkins

- [Què és Jenkins?](#què-és-jenkins)
- [Arquitectura](#arquitectura)
- [Tipus de tasques](#tipus-de-tasques)
- [Avantatges](#avantatges)
- [Instal·lació](#instal·lació)
- [Executant una primera tasca](#executant-una-primera-tasca)
- [Instal·lant plugins](#instal·lant-plugins)
- [Pipeline de Jenkins](#pipeline-de-jenkins)
- [Jenkinsfile](#jenkinsfile)
- [Conceptes clau](#conceptes-clau)
- [Sintaxi](#sintaxi)
  - [Seccions principals](#seccions-principals)
  - [Directives](#directives-principals)
- [La nostra primera pipeline](#la-nostra-primera-pipeline)
- [Credencials](#credencials)

---

## Què és Jenkins?

Jenkins és un servidor de codi obert que automatitza tasques relacionades amb la creació, prova o lliurament i implementació de programari.

---

## Arquitectura

Jenkins utilitza una arquitectura mestre/esclau:

- **Mestre**: Programa treballs, envia tasques als esclaus, monitoritza el seu estat i recupera resultats.
- **Esclau**: Executa els treballs enviats pel mestre.

---

## Tipus de tasques

Treballs o un conjunts d'instruccions programables
perquè ocorreguen junt amb una determinada acció

- **Projecte d'estil lliure**: Tasques simples.
- **Pipeline**: Fluxos de treball sencers.
- **Multiconfiguració**: Mateixa tasca s'executa en múltiples entorns.
- **Carpeta**: Organització de tasques.
- **Organització GitHub**: Escaneja comptes de GitHub per crear pipelines.
- **Multibranch pipeline**: Pipelines per a diferents branques d'un projecte.

---

## Avantatges

- Codi obert amb gran comunitat de suport.
- Configuració senzilla i extensible amb més de 1000 plugins.
- Basat en Java, compatible amb diverses plataformes.

---

## Instal·lació

Es pot instal·lar amb paquets del sistema, Docker o com a aplicació independent amb Java Runtime Environment.

### ex. Docker:

```bash
docker run -p 8080:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home -d jenkins/jenkins
```

## Executant una primera tasca

1. **Accedir a Jenkins**: Realitzar login.
2. **Crear nova tasca**: Assignar un nom, seleccionar "Projecte d'estil lliure" i prémer OK.
3. **Configurar la tasca**:
   - **General**: Descripció i historial.
   - **Repositori**: Configurar enllaç i branca de Git (si escau).
   - **Execució**: Especificar quan i com executar (manual, periòdic, remot...).
   - **Passos**: Definir accions concretes a realitzar.
   - **Post-execució**: Accions després d'acabar la tasca.
4. **Guardar i executar**: Prémer "Construir ara" per iniciar la tasca.
5. **Revisar l'execució**: Consultar l'historial i la consola de resultats.

---

## Instal·lació de plugins

1. **Accedir al marketplace**: [plugins.jenkins.io](https://plugins.jenkins.io/).
2. **Buscar un plugin**: Verificar compatibilitat, ús i documentació.
3. **Instal·lar**: Seleccionar "Instal·lar sense reiniciar" o "Instal·lar i reiniciar".
4. **Desinstal·lar**:
   - Eliminar el fitxer `.jpi` o `.hpi` de `/var/jenkins_home/plugins`.
   - Reiniciar Jenkins.
5. **Desactivar**: Afegir `.disabled` al fitxer `.jpi` o `.hpi` per evitar inicialitzar-lo.

## Pipeline de Jenkins

Una pipeline és un conjunt de complements que permet a Jenkins implementar e integrar processos d'entrega contínua de forma seqüencial o complexa. Simplifica la creació de seqüències de tasques que anteriorment requerien configuracions més complicades.

[Documentació oficial](https://www.jenkins.io/doc/book/pipeline/)

### Avantatges

- **Codi:** Implementació com a codi registrat al control de versions. Es editable i revisable
- **Pausable:** Pot parar-se i esperar intervencions humanes.
- **Versàtil:** Permet bucles, paral·lelisme i tasques complexes.
- **Extensible:** Compatible amb extensions i plugins.

---

## Jenkinsfile

Un **Jenkinsfile** és el fitxer on es defineix la pipeline. Es considera bona pràctica incloure'l al repositori del projecte.

Una pipeline també es pot definir a la interfice de Jenkins.

---

## Conceptes clau

- **Agent:** Màquina que executa la pipeline.
- **Stage:** Subdivisions de la pipeline (ex. "Build", "Test", "Deploy").
- **Step:** Tasques individuals dins d'una etapa (ex. `echo "Hola"`).

---

## Sintaxi

### Tipus de sintaxi

- **Declarativa:** Recomanada per la seva senzillesa i flexibilitat.
- **Imperativa:** Permet més flexibilitat, però és més complexa.

#### Exemple de una pipeline declarativa (llenguatge groovy):

```groovy
pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                echo 'Construint...'
            }
        }
        stage('Test') {
            steps {
                echo 'Provant...'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Desplegant...'
            }
        }
    }
}
```

## Seccions principals

1. **agent (requerit):** Defineix on s’executa la pipeline.

   - **any:** Executa la pipeline qualsevol agent disponible.
   - **none:** Cada stage deu de tindre definit el seu propi agent.
   - **docker:** Executa la pipeline en una Imatge Docker específica o un dockerfile.

2. **stages (requerit):** Conté les etapes de la pipeline.

3. **steps (requerit):** Accions (passos) a executar dins de cada `stage`.

4. **post (opcional):** Accions que es fan després d’una etapa segons condicions (e.g., `always`, `success`).

---

## Directives principals

1. **environment:** Defineix variables d’entorn, incloent-hi credencials. Parells clau-valor.

2. **options:** Defineix opcions a l'hora d'executar de la pipeline.

   - _retry:_ Torna a executar la pipeline n vegades
   - _timeout:_ Temps máxim per executar la pipeline
   - _timestamps:_ Mostra l'hora en les eixides per consola

3. **parameters:** Paràmetres que l’usuari pot definir abans d’executar la pipeline (string, text,booleanParam,..).

4. **triggers:** Configura execucions automàtiques (e.g., `cron` o `pollScm`).

5. **tools:** Eines que es poden autoinstalar al PATH. Deuen definir-se, Configuració > Configuració d'eines

6. **input:** Permet pausar la pipleline, per introduir valors per pantalla.
   - _message:_ Missatge que es mostra
   - _ok:_ Text del botó de submitt
   - _submitter:_ Usuaris autoritzats
   - _parameters:_ Parámetres utilitzables
7. **parallel:** Permet la paralelització a l'hora d'executar diferents stages

---

## La nostra primera pipeline

1. **Crear una tasca:**  
   Al menú principal de Jenkins, seleccionar “Nova Tasca”.

2. **Nom i configuració:**  
   Escriure un nom i seleccionar el tipus “Pipeline”.

3. **Definició del pipeline:**

   - Introduir el contingut directament.
   - Configurar un repositori que conté el `Jenkinsfile`.

4. **Executar la pipeline:**  
   Tornar al menú principal de la tasca i fer clic a “Construir ara”.

---

## Credencials

1. Usuari i password.
2. App de GitHub.
3. Usuari SSH.
4. Fitxer secret.
5. Text encriptat (secret).
6. Certificat.

### Configuració:

Es defineixen des del panell d’administració de Jenkins i es poden aplicar a:

- **Tot Jenkins.**
- **Ítems específics.**

---

---

# Pràctica

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
  (El plugin que permiteix fer us de les diferents versions de node ja l'havia descarregat i configurat globalment en les práctiques anteriors)
- Almacenará les dades que se li passen per input del UI de Jenkins com a parametres.(Les caracteristiques d' aquests parametres es veuen clarament en les captures)
- Hem creat una stage que mostre per consola els valors dels inputs aportats, per a comprovar que tot funciona correctamet.

![](capturas/dades/stages.png)

Captura config de node global:

![](capturas/dades/node.png)

Seguidament, creem una "Nueva Tarea" en Jenkins del tipus Pipeline.

![](capturas/dades/tarea.png)

Aquesta pipeline deu de configurarse. Hem de configurar la pipeline per a que utilitze el codi del repo de github. `Pipeline > Pipeline script from SCM > Github `. Afegim la url, la rama i les credencials que tenen el token. (Pareix que done error, pero es que el token era de tipus 'fine-grained' i només estava configurat per al repo de les práctiques anteriors de 'prova')

![](capturas/dades/pipe.png)

En aquest cas, l'exercici fa us d' un repo de github. Per a conseguir el codi del repo precisará d'un token (que ja tenia configurat com a secret global de les practiques anteriors).

![](capturas/dades/github_token.png)
![](capturas/dades/gh_token.png)

També, aquest pipeline deu ser configurada perque requerisca al usuari els tres parametres que haviem declarat en el Jenkinsfile. En `Esta ejecucion debe parametrizarse`, creem tres parametre de cadena y els asignem el mateix nom que tenen en el Jenkinsfile. (Les altres variables encara que no les fiquem, Jenkins les agafa de la declaració del Jenkinsfile)

![](capturas/dades/param_config.png)

![](capturas/dades/tarea.png)

Finalment, fem el commit i dins de `Jenkins > Tarea > Build with Parameters`, per tal de que comence a executar la pipeline. Al començar, es pausará per a demanar els parametres per pantalla. Una vegada introduits, la pipeline continuará executanse.
![](capturas/dades/params.png)

Captura del resultat, amb la impresió dels valors per consola.
![](capturas/dades/success.png)

#### Linter

En el meu cas no es precís instalar el plugin de eslint per a react. Ja que el framework Remix el du incorporat.
Captura del package.json
![](capturas/linter/package.png)

Creem una primera stage del pipeline que incorpore el codi que ha de fer que s'execute el linter per part del servidor Jenkins. Centrant-se en la stage. Solament te dos comandos:

- npm install , per aconseguir les dependencies
- npm run lint, per executar el linter.

![](capturas/linter/stage.png)

Executem el pipeline, en un primer moment:

![](capturas/linter/success.png)

Per a comprovar que `falla` quant hi ha un error, incorporem algunes regles al .eslint:

![](capturas/linter/reglas.png)

Creem una funció que no s'utilitza i que te un error de sintaxi.
![](capturas/linter/fallo.png)

Executem el pipeline, per a comprovar:

![](capturas/linter/run_fallo.png)

#### Test

Instalem jest en el nostre projecte
![](capturas/linter/npm_i.png)

Creem un arxiu jest.config.cjs per a establir la configuració de jest
![](capturas/test/jest_config.png)

Modifiquem el package.json per a incorporar un nou script per a poder executar jest
![](capturas/test/pkg.png)

Creem un arxiu func.ts en app > helpers que contindrá diverses funcions
![](capturas/test/functions.png)

Creem els tests de Jest en test > math.test.ts
![](capturas/test/tests.png)

Creem una nova stage dins del Jenkinsfile. Per agilizar, s´ha decidit extraure la instalacio de dependencies (npm install) al principi, per a que totes les stages que ho precisen fagen us d´ells.
![](capturas/test/jenkinsfile.png)

Fem el commit i comprovem en Jenkins
![](capturas/test/ok.png)

Introduim un `fallo` en els tests i comprovem en Jenkins que capture l'errror correctamen
![](capturas/test/fallo.png)
![](capturas/test/wrong.png)

#### Update Readme

Primer, modifiquem el README per donar lloc al badge en l'ultima part del document
![](capturas/badge/readme.png)

En /jenkinsScripts creem un nou arxiu `updateReadme.js` que contindra la funcionalitat per actualitzar el README.

- Una funcio que te un parametre que sera el resultat del test
- Segon el parametre (succesfu / failure) tindrá una image o altra
- LLig el document i modifica una secció amb uns comentaris especifics per a incloure el badge
- Es modifica l'arxiu README
- S'invoca a la funcio creada amb el parámetre que es passa al executar el script

![](capturas/badge/script.png)

Passant al jenkinsfile, creem una nova stage i modifiquem l' anterior stage que executava els tests.

- S' executen els tests i el resultat s'enmagatzema en una variable. Aquesta posteriorment, s'assignará a una variable d'entorn amb el valor success o failure. (Es fa ús del returnStatus per a controlar la resposta en cas de que fallen, i axí asignem el valor que volem i no s'interromp el flow del programa)
- S' executa el script anteriorment creat amb la variable d'entorn
  ![](capturas/badge/stage.png)

Fem un commit i executem la pipeline
![](capturas/badge/failure_ok.png)

#### Push Changes

Creem una nova stage dins del Jenkinsfile.

- Comprova que es troba en la rama correcta
- Afegix l' arxiu README
- Fa el commit amb els paràmetres que al principi em recopilat
- Fa el push a la branca

![](capturas/push/stage.png)

Executem la pipeline
![](capturas/push/test.png)
![](capturas/push/success.png)

Anem a github i comprovem el últim commit
![](capturas/push/commit.png)

Al final del document trobem el badge
![](capturas/push/ok.png)

Finalment, Adjunte captura del commit d'un badge amb els test havent fallat
![](capturas/push/fail.png)

#### Build

Creem una nova stage dins del Jenkinsfile. Aquesta solament fara us del comando _npm run build_, per a empaquetar el projecte
![](capturas/build/stage.png)

Fem un commit i comprovem en el pipeline de Jenkins que la execució haja sigut existosa
![](capturas/build/ok.png)

#### Deploy Vercel

Comencem creant un token a vercel per a que jenkins tinga permisos per a desplegar
![](capturas/vercel/vercel_token.png)

Guardem el token en una credencial global, per poder utilitzar-la en els pipelines de Jenkins
![](capturas/vercel/tok.png)
![](capturas/vercel/credencial.png)

Vinculem el projecte amb vercel, executant en consola vercel --link token -project nom_projecte
.Perque cree `.vercel/project.json` amb les caracteristiques del projecte
![](capturas/vercel/link.png)

Arxiu project.json
![](capturas/vercel/vercel_json.png)

Passem al projecte en si, primer creem el arxiu deployVercel.sh dins de /jenkinsScripts amb el seguent contingut:

- Si no se li passa el token de vercel, retorna un error
- En cas contrari, fa el deploy del projecte

![](capturas/vercel/script.png)

Canviem permisos del arxiu que conté el script, per a que la maquina de Jenkins puga exectuar-ho sense problemes.
![](capturas/vercel/chmod.png)

Creem una nova stage dins del jenkinsFile.

- S'executa si totes les demes stages han acabat be (success)

  - currentBuild.result == null: Significa que la build actual encara no té un resultat definit. Això passa quan s’executa per primera vegada.

  - currentBuild.result == 'SUCCESS': Significa que la build anterior o l’estat actual és SUCCESS. Això assegura que només es continuarà si tot ha anat bé.

- Primer instala el cli de vercel en la máquina de Jenkins
- Despres executa el script anteriorment creat amb el token de Vercel com a credencial global

![](capturas/vercel/stage.png)

Modifiquem el nostre projecte per a que no vinga "de serie"
![](capturas/vercel/mods.png)

Fem el commit i comprovem els logs del pipeline
![](capturas/vercel/ok.png)

Finalment, naveguem al deploy (url mes amigable que es troba en el dashboard de Vercel)
![](capturas/vercel/deploy.png)

#### Notificació

Comencem instalant la llibreria node-telegram-bot-api en el projecte. Així, quant en el primer stage s'execute el npm install, estará disponible.
![](capturas/notification/npm_i.png)

Guardem el token del bot de Telegram en una credencial global, per poder utilitzar-la en els pipelines de Jenkins. El token el tenimem a má, despres de realitzar la pràctica de Github Actions, pel que no ha fet falta tornar-lo a crear.
![](capturas/notification/token.png)

Creem un nou arxiu en `jenkinsScripts/notification.js`

- Crea un nou bot
- Agafa les cuatre variables dels procesos anteriors i la que inclou el Chat ID del primer punt.
- Es crea un missatge i el bot l' envia
  ![](capturas/notification/script.png)

Canviem permisos del arxiu que conté el script, per a la maquina de Jenkins
![](capturas/notification/chmod.png)

Creem una nova stage dins del jenkinsFile.

- Executa el script anteriorment creat amb el token del bot com a credencial global. A mes de passarli el resultat de les demes stages i el ID del chat
  ![](capturas/notification/stage.png)

Per a passar el resultat de les stages, hem decidit crear variables d' entorn amb el resultat de cadscuna.
![](capturas/notification/var_1.png)
![](capturas/notification/var_2.png)

Fem el commit i comprovem els logs del pipeline
![](capturas/notification/ok.png)

Finalment, visitem Telegram
![](capturas/notification/message.png)

Altra notificació amb un error en els tests
![](capturas/notification/failure.png)

### RESULTADO DE LOS ÚLTIMOS TESTS

<!---Start place for the badge -->
[![Cypress.io](https://img.shields.io/badge/tested%20with-Cypress-04C38E.svg)](https://www.cypress.io/)
<!---End place for the badge -->
