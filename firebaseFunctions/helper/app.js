const nodemailer = require("nodemailer")

const email = "registrierung@skolio-app.de"
const password = "Skolio!2021"

const transporter = nodemailer.createTransport({
    host: 'smtp.strato.de',
    port: 465,
    secure: true,
    auth: {
        user: email,
        pass: password,
    }
});

transporter.sendMail({
    from: '"Skolio Team" <registrierung@skolio-app.de>', // sender address
    to: "brahim.zeqiraj@hotmail.com", // list of receivers
    subject: "Verifiziere deinen Account", // Subject line
    text: `
    Herzlich Willkommen bei Skolio,

    wir freuen uns, dass Du Dich bei Skolio registrieren möchtest. Um Deine Registrierung abzuschließen, klicke bitte auf diesen Link: <Link>

    Dein Skolio-Team
    `, // plain text body
})