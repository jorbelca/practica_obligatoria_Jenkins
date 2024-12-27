const TelegramBot = require("node-telegram-bot-api");

try {
  // Configuración del Bot

  const bot = new TelegramBot(process.env.BOT_TOKEN);

  const chatID = process.argv[2];

  // Resultados de los jobs

  const linterResult = process.argv[3];
  const testResult = process.argv[4];
  const readmeResult = process.argv[5];
  const deployResult = process.argv[6];

  // Crear mensaje
  const message = `
        S'ha executat la pipeline de Jenkins amb els següents resultats:

        - *Linter_stage*: ${linterResult}
        - *Test_stage*: ${testResult}
        - *Update_readme_stage*: ${readmeResult}
        - *Deploy_to_vercel_stage*: ${deployResult}
`;
  // Enviar
  bot
    .sendMessage(chatID, message, { parse_mode: "Markdown" })
    .then(() => console.log("msg", "Mensaje enviado correctamente"))
    .catch((error) =>
      console.error(`Error al enviar mensaje: ${error.message}`)
    );
} catch (error) {
  console.error(`Action failed: ${error.message}`);
}
