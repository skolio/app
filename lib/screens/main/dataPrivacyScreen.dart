import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

class DataPrivacyScreen extends StatefulWidget {
  @override
  _DataPrivacyScreenState createState() => _DataPrivacyScreenState();
}

class _DataPrivacyScreenState extends State<DataPrivacyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Datenschutz",
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyText1.color,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 18,
            color: Theme.of(context).textTheme.bodyText1.color,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Html(
          data: """
            <html>

<head>
    <meta content="text/html; charset=UTF-8" http-equiv="content-type">
    <style type="text/css">
        @import url('https://themes.googleusercontent.com/fonts/css?kit=fpjTOVmNbO4Lz34iLyptLUXza5VhXqVC6o75Eld_V98');

        .lst-kix_list_1-3>li:before {
            content: "\0025cf  "
        }

        .lst-kix_list_1-4>li:before {
            content: "o  "
        }

        ul.lst-kix_list_1-0 {
            list-style-type: none
        }

        .lst-kix_list_1-7>li:before {
            content: "o  "
        }

        .lst-kix_list_1-5>li:before {
            content: "\0025aa  "
        }

        .lst-kix_list_1-6>li:before {
            content: "\0025cf  "
        }

        ul.lst-kix_list_1-3 {
            list-style-type: none
        }

        .lst-kix_list_1-0>li:before {
            content: "-  "
        }

        ul.lst-kix_list_1-4 {
            list-style-type: none
        }

        .lst-kix_list_1-8>li:before {
            content: "\0025aa  "
        }

        ul.lst-kix_list_1-1 {
            list-style-type: none
        }

        ul.lst-kix_list_1-2 {
            list-style-type: none
        }

        ul.lst-kix_list_1-7 {
            list-style-type: none
        }

        .lst-kix_list_1-1>li:before {
            content: "o  "
        }

        .lst-kix_list_1-2>li:before {
            content: "\0025aa  "
        }

        ul.lst-kix_list_1-8 {
            list-style-type: none
        }

        ul.lst-kix_list_1-5 {
            list-style-type: none
        }

        ul.lst-kix_list_1-6 {
            list-style-type: none
        }

        ol {
            margin: 0;
            padding: 0
        }

        table td,
        table th {
            padding: 0
        }

        .c7 {
            color: #000000;
            font-weight: 400;
            text-decoration: none;
            vertical-align: baseline;
            font-size: 10.5pt;
            font-family: "Calibri";
            font-style: normal
        }

        .c4 {
            color: #000000;
            font-weight: 400;
            text-decoration: none;
            vertical-align: baseline;
            font-size: 10pt;
            font-family: "Calibri";
            font-style: normal
        }

        .c1 {
            color: #000000;
            font-weight: 400;
            text-decoration: none;
            vertical-align: baseline;
            font-size: 14pt;
            font-family: "Calibri";
            font-style: normal
        }

        .c3 {
            color: #000000;
            font-weight: 400;
            text-decoration: none;
            vertical-align: baseline;
            font-size: 11.5pt;
            font-family: "Calibri";
            font-style: normal
        }

        .c6 {
            -webkit-text-decoration-skip: none;
            color: #0563c1;
            font-weight: 400;
            text-decoration: underline;
            text-decoration-skip-ink: none;
            font-family: "Arial"
        }

        .c0 {
            padding-top: 0pt;
            padding-bottom: 0pt;
            line-height: 1.0;
            orphans: 2;
            widows: 2;
            text-align: left
        }

        .c8 {
            background-color: #ffffff;
            max-width: 453.3pt;
            padding: 10.0pt 20.0pt 10.0pt 20.0pt
        }

        .c9 {
            color: inherit;
            text-decoration: inherit
        }

        .c5 {
            font-size: 10pt
        }

        .c2 {
            height: 12pt
        }

        .title {
            padding-top: 24pt;
            color: #000000;
            font-weight: 700;
            font-size: 36pt;
            padding-bottom: 6pt;
            font-family: "Calibri";
            line-height: 1.0;
            page-break-after: avoid;
            orphans: 2;
            widows: 2;
            text-align: left
        }

        .subtitle {
            padding-top: 18pt;
            color: #666666;
            font-size: 24pt;
            padding-bottom: 4pt;
            font-family: "Georgia";
            line-height: 1.0;
            page-break-after: avoid;
            font-style: italic;
            orphans: 2;
            widows: 2;
            text-align: left
        }

        li {
            color: #000000;
            font-size: 12pt;
            font-family: "Calibri"
        }

        p {
            margin: 0;
            color: #000000;
            font-size: 12pt;
            font-family: "Calibri"
        }

        h1 {
            padding-top: 0pt;
            color: #000000;
            font-weight: 700;
            font-size: 24pt;
            padding-bottom: 0pt;
            font-family: "Times New Roman";
            line-height: 1.0;
            orphans: 2;
            widows: 2;
            text-align: left
        }

        h2 {
            padding-top: 0pt;
            color: #000000;
            font-weight: 700;
            font-size: 18pt;
            padding-bottom: 0pt;
            font-family: "Times New Roman";
            line-height: 1.0;
            orphans: 2;
            widows: 2;
            text-align: left
        }

        h3 {
            padding-top: 2pt;
            color: #1f3863;
            font-size: 12pt;
            padding-bottom: 0pt;
            font-family: "Calibri";
            line-height: 1.0;
            page-break-after: avoid;
            orphans: 2;
            widows: 2;
            text-align: left
        }

        h4 {
            padding-top: 12pt;
            color: #000000;
            font-weight: 700;
            font-size: 12pt;
            padding-bottom: 2pt;
            font-family: "Calibri";
            line-height: 1.0;
            page-break-after: avoid;
            orphans: 2;
            widows: 2;
            text-align: left
        }

        h5 {
            padding-top: 11pt;
            color: #000000;
            font-weight: 700;
            font-size: 11pt;
            padding-bottom: 2pt;
            font-family: "Calibri";
            line-height: 1.0;
            page-break-after: avoid;
            orphans: 2;
            widows: 2;
            text-align: left
        }

        h6 {
            padding-top: 10pt;
            color: #000000;
            font-weight: 700;
            font-size: 10pt;
            padding-bottom: 2pt;
            font-family: "Calibri";
            line-height: 1.0;
            page-break-after: avoid;
            orphans: 2;
            widows: 2;
            text-align: left
        }
    </style>
</head>

<body class="c8">
    <p class="c0"><span class="c1">Datenschutzhinweise</span></p>
    <p class="c0"><span class="c4">Mit diesen Hinweisen informieren wir dich &uuml;ber die Verarbeitung deiner
            personenbezogenen Daten durch die Skolio App und die dir nach dem Datenschutzrecht zustehenden Rechte.
        </span></p>
    <p class="c0 c2"><span class="c4"></span></p>
    <p class="c0"><span class="c4">Verantwortliche Stelle im Sinne der Datenschutzgesetze, insbesondere der
            EU-Datenschutzgrundverordnung (DSGVO), ist:</span></p>
    <p class="c0"><span class="c4">Skolio App</span></p>
    <p class="c0"><span class="c4">Florian Zenk</span></p>
    <p class="c0"><span class="c4">Markgrafenstr. 12</span></p>
    <p class="c0"><span class="c4">90459 N&uuml;rnberg</span></p>
    <p class="c0"><span class="c5 c6"><a class="c9" href="mailto:info@skolio-app.de">info@skolio-app.de</a></span></p>
    <p class="c0 c2"><span class="c3"></span></p>
    <p class="c0 c2"><span class="c3"></span></p>
    <p class="c0"><span class="c1">Deine Betroffenenrechte</span></p>
    <p class="c0"><span class="c4">Du kannst unter der E-Mail-Adresse&nbsp;info@skolio-app.de &uuml;ber die zu deiner
            Person gespeicherten Daten verlangen. Dar&uuml;ber hinaus kannst du unter bestimmten Voraussetzungen die
            Berichtigung oder die L&ouml;schung deiner Daten verlangen. Dir kann weiterhin ein Recht auf
            Einschr&auml;nkung der Verarbeitung deiner Daten sowie ein Recht auf Herausgabe der von dir bereitgestellten
            Daten in einem strukturierten, g&auml;ngigen und maschinenlesbaren Format zustehen.</span></p>
    <p class="c0 c2"><span class="c4"></span></p>
    <p class="c0"><span class="c1">Beschwerderecht</span></p>
    <p class="c0"><span class="c4">Du hast die M&ouml;glichkeit, dich mit einer Beschwerde an den o. g.
            Datenschutzbeauftragten oder an eine Datenschutzaufsichtsbeh&ouml;rde zu wenden. Die f&uuml;r uns
            zust&auml;ndige Datenschutzaufsichtsbeh&ouml;rde ist:</span></p>
    <p class="c0 c2"><span class="c4"></span></p>
    <p class="c0"><span class="c4">Bayerisches Landesamt f&uuml;r Datenschutzaufsicht</span></p>
    <p class="c0"><span class="c4">Promenade 18, 91522 Ansbach</span></p>
    <p class="c0"><span class="c4">Postanschrift: Postfach 606, 91511 Ansbach</span></p>
    <p class="c0"><span class="c4">Telefon: 0981/180093-0</span></p>
    <p class="c0"><span class="c4">Telefax: 0981/180093-99</span></p>
    <p class="c0"><span class="c5">E-Mail: </span><span class="c5"><a class="c9"
                href="mailto:poststelle@lda.bayern.de">poststelle@lda.bayern.de</a></span></p>
    <p class="c0"><span class="c5">Homepage: </span><span class="c5"><a class="c9"
                href="https://www.google.com/url?q=https://ida.bayern.de&amp;sa=D&amp;source=editors&amp;ust=1636724191211000&amp;usg=AOvVaw3hJGG7uJgAuEn1V2aPaFlI">https://Ida.bayern.de</a></span>
    </p>
    <p class="c0 c2"><span class="c4"></span></p>
    <p class="c0"><span class="c1">Widerspruchsrecht</span></p>
    <p class="c0"><span class="c4">Du hast das Recht, einer Verarbeitung deiner personenbezogenen Daten zu
            widersprechen. Verarbeiten wir deine Daten zur Wahrung berechtigter Interessen, kannst du dieser
            Verarbeitung widersprechen, wenn sich aus deiner besonderen Situation Gr&uuml;nde ergeben, die gegen die
            Datenverarbeitung sprechen.</span></p>
    <p class="c0 c2"><span class="c7"></span></p>
    <p class="c0"><span class="c1">Recht auf Daten&uuml;bertragbarkeit</span></p>
    <p class="c0"><span class="c4">Dir steht das Recht zu, Daten, die wir auf Grundlage deiner Einwilligung oder in
            Erf&uuml;llung eines Vertrags automatisiert verarbeiten, an dich oder an Dritte aush&auml;ndigen zu lassen.
            Die Bereitstellung erfolgt in einem maschinenlesbaren Format. Sofern du die direkte &Uuml;bertragung der
            Daten an einen anderen Verantwortlichen verlangst, erfolgt dies nur, soweit es technisch machbar ist.</span>
    </p>
    <p class="c0 c2"><span class="c7"></span></p>
    <p class="c0"><span class="c1">Zwecke der Datenverarbeitung durch die verantwortliche Stelle und Dritte&nbsp;</span>
    </p>
    <p class="c0"><span class="c4">Die Betreiber dieser App nehmen den Schutz deiner pers&ouml;nlichen Daten sehr ernst.
            Wir behandeln deine personenbezogenen Daten vertraulich und entsprechend der gesetzlichen
            Datenschutzvorschriften sowie dieser Datenschutzerkl&auml;rung. Wir verarbeiten deine personenbezogenen
            Daten unter Beachtung der EU-Datenschutz-Grundverordnung (DS-GVO).</span></p>
    <p class="c0 c2"><span class="c4"></span></p>
    <p class="c0"><span class="c4">Du hast die M&ouml;glichkeit dich in unserer App, unter Angabe von personenbezogenen
            Daten (E-Mailadresse) zu registrieren. Die von dir eingegebenen Daten, werden in unserer Datenbank
            gespeichert. Dir steht es frei, die bei der Registrierung angegebenen Daten jederzeit zu &auml;ndern oder
            sich vollst&auml;ndig aus unserer Datenbank l&ouml;schen zu lassen. Die Verarbeitung deiner Daten zu diesem
            Zweck erfolgt auf Grund des vorvertraglichen Verh&auml;ltnisses mit Dir (Art. 6 Abs. 1 S.1. lit. b)
            DS-GVO).</span></p>
    <p class="c0 c2"><span class="c4"></span></p>
    <p class="c0"><span class="c4">Durch die Nutzung von Skolio werden personenbezogene Daten erfasst, die abh&auml;ngig
            von deiner individuellen Nutzung sind.</span></p>
    <p class="c0 c2"><span class="c4"></span></p>
    <p class="c0"><span class="c4">Die folgenden Daten werden bei der Nutzung von Skolio erfasst:</span></p>
    <p class="c0"><span class="c4">E-Mailadresse</span></p>
    <p class="c0"><span class="c4">Trainingsergebnisse</span></p>
    <p class="c0"><span class="c4">Angelegte &Uuml;bungen inklusive dazugeh&ouml;rige Bilder</span></p>
    <p class="c0 c2"><span class="c4"></span></p>
    <p class="c0"><span class="c4">Diese Informationen werden verschl&uuml;sselt in unserer Datenbank hinterlegt. Die
            Verarbeitung deiner Daten zu diesem Zweck erfolgt auf Grund des vorvertraglichen Verh&auml;ltnis mit dir
            (Art. 6 Abs. 1 S. 1 lit. b) DS-GVO).</span></p>
    <p class="c0 c2"><span class="c4"></span></p>
    <p class="c0"><span class="c4">Des weiteren kann es sein, dass es uns gesetzlich vorgeschrieben ist, deine Daten zu
            verarbeiten. Diese Verarbeitung, ist dann zur Erf&uuml;llung einer gesetzlichen Verpflichtung erforderlich
            (Art. 6 Abs. 1 S. 1 lit. c) DS-GVO). Dies ist zum Beispiel in solchen Situationen der Fall, wenn wir durch
            Gesetz bestimmte Aufbewahrungsfristen haben.</span></p>
    <p class="c0 c2"><span class="c7"></span></p>
    <p class="c0"><span class="c1">Daten&uuml;bermittlung an Dritte</span></p>
    <p class="c0"><span class="c4">Wir verarbeiten deine personenbezogenen Daten nur zu den in dieser
            Datenschutzerkl&auml;rung genannten Zwecken. Eine &Uuml;bermittlung deiner pers&ouml;nlichen Daten an Dritte
            zu anderen als den genannten Zwecken findet nicht statt.</span></p>
    <p class="c0 c2"><span class="c7"></span></p>
    <p class="c0"><span class="c1">Google Cloud Plattform</span></p>
    <p class="c0"><span class="c4">Wir hosten unsere Systeme bei Google Inc. F&uuml;r den europ&auml;ischen Raum ist das
            Unternehmen Google Ireland Limited (Gordon House, Barrow Street Dublin 4, Irland) f&uuml;r alle
            Google-Dienste verantwortlich. Die Systeme werden auf Servern des Google Cloud Netzwerks innerhalb der
            Europ&auml;ischen Union gehostet. </span></p>
    <p class="c0 c2"><span class="c4"></span></p>
    <p class="c0"><span class="c4">Entsprechend Art. 28 DS-GVO haben wir einen Vertrag zur Auftragsverarbeitung
            (Data-Processing-Agreement) mit Google abgeschlossen. Dabei handelt es sich um einen Vertrag, in dem sich
            Google unter anderem dazu verpflichtet, die Daten unserer Nutzer zu sch&uuml;tzen, entsprechend den
            festgehaltenen Datenschutzbestimmungen in unserem Auftrag zu verarbeiten und insbesondere nicht an Dritte
            weiterzugeben.</span></p>
    <p class="c0 c2"><span class="c4"></span></p>
    <p class="c0"><span class="c5">N&auml;here Informationen hierzu findest du in der Datenschutzerkl&auml;rung von
            Google (</span><span class="c5"><a class="c9"
                href="https://www.google.com/url?q=https://cloud.google.com/terms/data-processing-terms&amp;sa=D&amp;source=editors&amp;ust=1636724191214000&amp;usg=AOvVaw1yqaTo24ZZvtFUNFSJRRnG">https://cloud.google.com/terms/data-processing-terms</a></span><span
            class="c4">).</span></p>
    <p class="c0 c2"><span class="c4"></span></p>
    <p class="c0"><span class="c4">Die Rechtsgrundlage lautet berechtigtes Interesse (Art. 6 Abs. 1 S. 1 lit. f) DS-GVO)
            um die App funktionsf&auml;hig zu machen.</span></p>
    <p class="c0 c2"><span class="c4"></span></p>
    <p class="c0"><span class="c4">Google verarbeitet Daten u.a. auch in den USA. Wir weisen darauf hin, dass nach
            Meinung des Europ&auml;ischen Gerichtshofs derzeit kein angemessenes Schutzniveau f&uuml;r den Datentransfer
            in die USA besteht. Dies kann mit verschiedenen Risiken f&uuml;r die Rechtm&auml;&szlig;igkeit und
            Sicherheit der Datenverarbeitung einhergehen.</span></p>
    <p class="c0 c2"><span class="c7"></span></p>
    <p class="c0"><span class="c1">Fragen zum Datenschutz</span></p>
    <p class="c0"><span class="c4">Wenn du Fragen zum Datenschutz hast, schreib uns bitte eine E-Mail. Die Kontaktdaten
            findest du am Anfang des Datenschutzhinweises.</span></p>
    <p class="c0 c2"><span class="c4"></span></p>
</body>

</html>

            """,
        ),
//           child: Html(
//             data:
//                 """
//             <H2 CLASS="western" STYLE="background: #ffffff; border: none; padding: 0in">
// Datenschutz</H2>
// <P STYLE="margin-bottom: 0in; background: #ffffff; border: none; padding: 0in">
// Die Betreiber dieser App nehmen den Schutz Ihrer persönlichen Daten
// sehr ernst. Wir behandeln Ihre personenbezogenen Daten vertraulich
// und entsprechend der gesetzlichen Datenschutzvorschriften sowie
// dieser Datenschutzerklärung.</P>
// <P STYLE="margin-bottom: 0in; background: #ffffff; border: none; padding: 0in">
// Die Nutzung unserer App ist in der Regel ohne Angabe
// personenbezogener Daten möglich. Soweit auf unseren Appn
// personenbezogene Daten (beispielsweise Name, Anschrift oder
// E-Mail-Adressen) erhoben werden, erfolgt dies, soweit möglich, stets
// auf freiwilliger Basis. Diese Daten werden ohne Ihre ausdrückliche
// Zustimmung nicht an Dritte weitergegeben.</P>
// <P STYLE="margin-bottom: 0in; background: #ffffff; border: none; padding: 0in">
// Wir weisen darauf hin, dass die Datenübertragung im Internet (z.B.
// bei der Kommunikation per E-Mail) Sicherheitslücken aufweisen kann.
// Ein lückenloser Schutz der Daten vor dem Zugriff durch Dritte ist
// nicht möglich.</P>

// <H2 CLASS="western" STYLE="background: #ffffff; border: none; padding: 0in">
// Datenschutzerklärung für die Nutzung von Google Analytics</H2>
// <P STYLE="margin-bottom: 0in; background: #ffffff; border: none; padding: 0in">
// Diese App nutzt Funktionen des Webanalysedienstes Google Analytics.
// Anbieter ist die Google Inc., 1600 Amphitheatre Parkway Mountain
// View, CA 94043, USA.</P>
// <P STYLE="margin-bottom: 0in; background: #ffffff; border: none; padding: 0in">
// Google Analytics verwendet sog. &quot;Cookies&quot;. Das sind
// Textdateien, die auf Ihrem Computer gespeichert werden und die eine
// Analyse der Benutzung der Website durch Sie ermöglichen. Die durch
// den Cookie erzeugten Informationen über Ihre Benutzung dieser
// Website werden in der Regel an einen Server von Google in den USA
// übertragen und dort gespeichert.</P>
// <P STYLE="margin-bottom: 0in; background: #ffffff; border: none; padding: 0in">
// Mehr Informationen zum Umgang mit Nutzerdaten bei Google Analytics
// finden Sie in der Datenschutzerklärung von Google:
// <A HREF="https://support.google.com/analytics/answer/6004245?hl=de"><FONT COLOR="#0000ee"><U>https://support.google.com/analytics/answer/6004245?hl=de</U></FONT></A></P>
// <P STYLE="margin-bottom: 0in; background: #ffffff; border: none; padding: 0in">
// <B>Browser Plugin</B></P>
// <P STYLE="margin-bottom: 0in; background: #ffffff; border: none; padding: 0in">
// Sie können die Speicherung der Cookies durch eine entsprechende
// Einstellung Ihrer Browser-Software verhindern; wir weisen Sie jedoch
// darauf hin, dass Sie in diesem Fall gegebenenfalls nicht sämtliche
// Funktionen dieser Website vollumfänglich werden nutzen können. Sie
// können darüber hinaus die Erfassung der durch das Cookie erzeugten
// und auf Ihre Nutzung der Website bezogenen Daten (inkl. Ihrer
// IP-Adresse) an Google sowie die Verarbeitung dieser Daten durch
// Google verhindern, indem sie das unter dem folgenden Link verfügbare
// Browser-Plugin herunterladen und installieren:
// <A HREF="https://tools.google.com/dlpage/gaoptout?hl=de"><FONT COLOR="#0000ee"><U>https://tools.google.com/dlpage/gaoptout?hl=de</U></FONT></A></P>
// <P STYLE="margin-bottom: 0in; background: #ffffff; border: none; padding: 0in">
// <B>Widerspruch gegen Datenerfassung</B></P>
// <P STYLE="margin-bottom: 0in; background: #ffffff; border: none; padding: 0in">
// Sie können die Erfassung Ihrer Daten durch Google Analytics
// verhindern, indem Sie auf folgenden Link klicken. Es wird ein
// Opt-Out-Cookie gesetzt, dass das Erfassung Ihrer Daten bei
// zukünftigen Besuchen dieser Website verhindert: Google Analytics
// deaktivieren</P>
// <P STYLE="margin-bottom: 0in; background: #ffffff; border: none; padding: 0in">
// <B>Auftragsdatenverarbeitung</B></P>
// <P STYLE="margin-bottom: 0in; background: #ffffff; border: none; padding: 0in">
// Wir haben mit Google einen Vertrag zur Auftragsdatenverarbeitung
// abgeschlossen und setzen die strengen Vorgaben der deutschen
// Datenschutzbehörden bei der Nutzung von Google Analytics vollständig
// um.</P>
// <P STYLE="margin-bottom: 0in; background: #ffffff; border: none; padding: 0in">
// <B>IP-Anonymisierung</B></P>
// <P STYLE="margin-bottom: 0in; background: #ffffff; border: none; padding: 0in">
// Wir nutzen die Funktion &quot;Aktivierung der IP-Anonymisierung&quot;
// auf dieser App. Dadurch wird Ihre IP-Adresse von Google jedoch
// innerhalb von Mitgliedstaaten der Europäischen Union oder in anderen
// Vertragsstaaten des Abkommens über den Europäischen Wirtschaftsraum
// zuvor gekürzt. Nur in Ausnahmefällen wird die volle IP-Adresse an
// einen Server von Google in den USA übertragen und dort gekürzt. Im
// Auftrag des Betreibers dieser Website wird Google diese Informationen
// benutzen, um Ihre Nutzung der Website auszuwerten, um Reports über
// die Websiteaktivitäten zusammenzustellen und um weitere mit der
// Websitenutzung und der Internetnutzung verbundene Dienstleistungen
// gegenüber dem Websitebetreiber zu erbringen. Die im Rahmen von
// Google Analytics von Ihrem Browser übermittelte IP-Adresse wird
// nicht mit anderen Daten von Google zusammengeführt.</P>
// <H2 CLASS="western" STYLE="margin-top: 0in; background: #ffffff; border: none; padding: 0in; line-height: 100%">
// Datenschutzerklärung für die Nutzung von Facebook-Plugins
// (Like-Button)</H2>
// <P STYLE="margin-bottom: 0in; background: #ffffff; border: none; padding: 0in">
// Auf unseren Apps sind Plugins des sozialen Netzwerks Facebook,
// Anbieter Facebook Inc., 1 Hacker Way, Menlo Park, California 94025,
// USA, integriert. Die Facebook-Plugins erkennen Sie an dem
// Facebook-Logo oder dem &quot;Like-Button&quot; (&quot;Gefällt mir&quot;)
// auf unserer App. Eine übersicht über die Facebook-Plugins finden
// Sie hier: <A HREF="http://developers.facebook.com/docs/plugins/"><FONT COLOR="#0000ee"><U>http://developers.facebook.com/docs/plugins/</U></FONT></A>.</P>
// <P STYLE="margin-bottom: 0in; background: #ffffff; border: none; padding: 0in">
// Wenn Sie unsere Apps besuchen, wird über das Plugin eine direkte
// Verbindung zwischen Ihrem Browser und dem Facebook-Server
// hergestellt. Facebook erhält dadurch die Information, dass Sie mit
// Ihrer IP-Adresse unsere App besucht haben. Wenn Sie den Facebook
// &quot;Like-Button&quot; anklicken während Sie in Ihrem
// Facebook-Account eingeloggt sind, können Sie die Inhalte unserer
// Apps auf Ihrem Facebook-Profil verlinken. Dadurch kann Facebook den
// Besuch unserer Apps Ihrem Benutzerkonto zuordnen. Wir weisen darauf
// hin, dass wir als Anbieter der Apps keine Kenntnis vom Inhalt der
// übermittelten Daten sowie deren Nutzung durch Facebook erhalten.
// Weitere Informationen hierzu finden Sie in der Datenschutzerklärung
// von Facebook unter <A HREF="http://de-de.facebook.com/policy.php"><FONT COLOR="#0000ee"><U>http://de-de.facebook.com/policy.php</U></FONT></A>.</P>
// <P STYLE="margin-bottom: 0in; background: #ffffff; border: none; padding: 0in">
// Wenn Sie nicht wünschen, dass Facebook den Besuch unserer Apps Ihrem
// Facebook-Nutzerkonto zuordnen kann, loggen Sie sich bitte aus Ihrem
// Facebook-Benutzerkonto aus.</P>
// <H2 CLASS="western" STYLE="background: #ffffff; border: none; padding: 0in">
// Auskunft, Löschung, Sperrung</H2>
// <P STYLE="margin-bottom: 0in; background: #ffffff; border: none; padding: 0in">
// Sie haben jederzeit das Recht auf unentgeltliche Auskunft über Ihre
// gespeicherten personenbezogenen Daten, deren Herkunft und Empfänger
// und den Zweck der Datenverarbeitung sowie ein Recht auf Berichtigung,
// Sperrung oder Löschung dieser Daten. Hierzu sowie zu weiteren Fragen
// zum Thema personenbezogene Daten können Sie sich jederzeit unter der
// im Impressum angegebenen Adresse an uns wenden.</P>
// <H2 CLASS="western" STYLE="background: #ffffff; border: none; padding: 0in">
// Widerspruch Werbe-Mails</H2>
// <P STYLE="margin-bottom: 0in; background: #ffffff; border: none; padding: 0in">
// Der Nutzung von im Rahmen der Impressumspflicht veröffentlichten
// Kontaktdaten zur Übersendung von nicht ausdrücklich angeforderter
// Werbung und Informationsmaterialien wird hiermit widersprochen. Die
// Betreiber der Apps behalten sich ausdrücklich rechtliche Schritte im
// Falle der unverlangten Zusendung von Werbeinformationen, etwa durch
// Spam-E-Mails, vor.</P>
// <H2 CLASS="western"><A NAME="_80d6y456m49x"></A>Änderung der
// Datenschutzbestimmungen</H2>
// <P STYLE="margin-bottom: 0in">Wir behalten uns das Recht vor, diese
// Datenschutzbedingungen jederzeit unter Beachtung der geltenden
// Datenschutzgesetze zu verändern.</P>
// <P STYLE="margin-bottom: 0in; background: #ffffff; border: none; padding: 0in">
// <BR>
// </P>
//             """,
//             onLinkTap: (url, context, attributes, _) {
//               launch(url);
//             },
//           ),
      ),
    );
  }
}
