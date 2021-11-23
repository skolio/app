const functions = require("firebase-functions");
const admin = require("firebase-admin")

admin.initializeApp()


exports.sendVerificationEmail = functions.auth.user().onCreate((user) => {
    const email = "registrierung@skolio-app.de"
    const password = "Skolio!2021"

    functions.logger.info("We have a new User and we want to send the VerificationEmail")
    functions.logger.info(`Email is being sent to ${user.email}`)


    const nodemailer = require("nodemailer")

    user.emailVerified = false

    functions.logger.info()

    let transporter = nodemailer.createTransport({
        host: 'smtp.strato.de',
        port: 465,
        secure: true,
        auth: {
            user: email,
            pass: password,
        }
    })

    transporter.sendMail({
        from: '"Skolio-Team" <registrierung@skolio-app.de>',
        to: user.email,
        subject: "Bestätige deinen Account",
        html: `
        Herzlich Willkommen bei Skolio,

        wir freuen uns, dass Du Dich bei Skolio registrieren möchtest. Um Deine Registrierung abzuschließen, klicke bitte auf diesen Link: https://us-central1-skolio-fa10e.cloudfunctions.net/verifyUser?id=${user.uid}
    
        Dein Skolio-Team`,
    })

})

exports.verifyUser = functions.https.onRequest(async (req, res) => {
    functions.logger.info(`We want to verify the User right now ${req.query.id}`)

    admin.auth().updateUser(req.query.id, { emailVerified: true })

    res.status(200).send(`
        <html>
            <center>
                <img src="https://firebasestorage.googleapis.com/v0/b/skolio-fa10e.appspot.com/o/Logo.png?alt=media&token=8ed11828-4dbc-48d8-9107-2d725cb47001" alt="Logo"></img>
                <h3>Dein Account wurde erfolgreich Verifiziert!</h3>
            </center>    
        </html>
    `)
})