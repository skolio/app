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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: 30,
            bottom: 40,
            left: 30,
            right: 30,
          ),
          child: Html(
            data: """
            <H2 CLASS="western" STYLE="background: #ffffff; border: none; padding: 0in">
Datenschutz</H2>
<P STYLE="margin-bottom: 0in; background: #ffffff; border: none; padding: 0in">
Die Betreiber dieser App nehmen den Schutz Ihrer persönlichen Daten
sehr ernst. Wir behandeln Ihre personenbezogenen Daten vertraulich
und entsprechend der gesetzlichen Datenschutzvorschriften sowie
dieser Datenschutzerklärung.</P>
<P STYLE="margin-bottom: 0in; background: #ffffff; border: none; padding: 0in">
Die Nutzung unserer App ist in der Regel ohne Angabe
personenbezogener Daten möglich. Soweit auf unseren Appn
personenbezogene Daten (beispielsweise Name, Anschrift oder
E-Mail-Adressen) erhoben werden, erfolgt dies, soweit möglich, stets
auf freiwilliger Basis. Diese Daten werden ohne Ihre ausdrückliche
Zustimmung nicht an Dritte weitergegeben.</P>
<P STYLE="margin-bottom: 0in; background: #ffffff; border: none; padding: 0in">
Wir weisen darauf hin, dass die Datenübertragung im Internet (z.B.
bei der Kommunikation per E-Mail) Sicherheitslücken aufweisen kann.
Ein lückenloser Schutz der Daten vor dem Zugriff durch Dritte ist
nicht möglich.</P>

<H2 CLASS="western" STYLE="background: #ffffff; border: none; padding: 0in">
Datenschutzerklärung für die Nutzung von Google Analytics</H2>
<P STYLE="margin-bottom: 0in; background: #ffffff; border: none; padding: 0in">
Diese App nutzt Funktionen des Webanalysedienstes Google Analytics.
Anbieter ist die Google Inc., 1600 Amphitheatre Parkway Mountain
View, CA 94043, USA.</P>
<P STYLE="margin-bottom: 0in; background: #ffffff; border: none; padding: 0in">
Google Analytics verwendet sog. &quot;Cookies&quot;. Das sind
Textdateien, die auf Ihrem Computer gespeichert werden und die eine
Analyse der Benutzung der Website durch Sie ermöglichen. Die durch
den Cookie erzeugten Informationen über Ihre Benutzung dieser
Website werden in der Regel an einen Server von Google in den USA
übertragen und dort gespeichert.</P>
<P STYLE="margin-bottom: 0in; background: #ffffff; border: none; padding: 0in">
Mehr Informationen zum Umgang mit Nutzerdaten bei Google Analytics
finden Sie in der Datenschutzerklärung von Google:
<A HREF="https://support.google.com/analytics/answer/6004245?hl=de"><FONT COLOR="#0000ee"><U>https://support.google.com/analytics/answer/6004245?hl=de</U></FONT></A></P>
<P STYLE="margin-bottom: 0in; background: #ffffff; border: none; padding: 0in">
<B>Browser Plugin</B></P>
<P STYLE="margin-bottom: 0in; background: #ffffff; border: none; padding: 0in">
Sie können die Speicherung der Cookies durch eine entsprechende
Einstellung Ihrer Browser-Software verhindern; wir weisen Sie jedoch
darauf hin, dass Sie in diesem Fall gegebenenfalls nicht sämtliche
Funktionen dieser Website vollumfänglich werden nutzen können. Sie
können darüber hinaus die Erfassung der durch das Cookie erzeugten
und auf Ihre Nutzung der Website bezogenen Daten (inkl. Ihrer
IP-Adresse) an Google sowie die Verarbeitung dieser Daten durch
Google verhindern, indem sie das unter dem folgenden Link verfügbare
Browser-Plugin herunterladen und installieren:
<A HREF="https://tools.google.com/dlpage/gaoptout?hl=de"><FONT COLOR="#0000ee"><U>https://tools.google.com/dlpage/gaoptout?hl=de</U></FONT></A></P>
<P STYLE="margin-bottom: 0in; background: #ffffff; border: none; padding: 0in">
<B>Widerspruch gegen Datenerfassung</B></P>
<P STYLE="margin-bottom: 0in; background: #ffffff; border: none; padding: 0in">
Sie können die Erfassung Ihrer Daten durch Google Analytics
verhindern, indem Sie auf folgenden Link klicken. Es wird ein
Opt-Out-Cookie gesetzt, dass das Erfassung Ihrer Daten bei
zukünftigen Besuchen dieser Website verhindert: Google Analytics
deaktivieren</P>
<P STYLE="margin-bottom: 0in; background: #ffffff; border: none; padding: 0in">
<B>Auftragsdatenverarbeitung</B></P>
<P STYLE="margin-bottom: 0in; background: #ffffff; border: none; padding: 0in">
Wir haben mit Google einen Vertrag zur Auftragsdatenverarbeitung
abgeschlossen und setzen die strengen Vorgaben der deutschen
Datenschutzbehörden bei der Nutzung von Google Analytics vollständig
um.</P>
<P STYLE="margin-bottom: 0in; background: #ffffff; border: none; padding: 0in">
<B>IP-Anonymisierung</B></P>
<P STYLE="margin-bottom: 0in; background: #ffffff; border: none; padding: 0in">
Wir nutzen die Funktion &quot;Aktivierung der IP-Anonymisierung&quot;
auf dieser App. Dadurch wird Ihre IP-Adresse von Google jedoch
innerhalb von Mitgliedstaaten der Europäischen Union oder in anderen
Vertragsstaaten des Abkommens über den Europäischen Wirtschaftsraum
zuvor gekürzt. Nur in Ausnahmefällen wird die volle IP-Adresse an
einen Server von Google in den USA übertragen und dort gekürzt. Im
Auftrag des Betreibers dieser Website wird Google diese Informationen
benutzen, um Ihre Nutzung der Website auszuwerten, um Reports über
die Websiteaktivitäten zusammenzustellen und um weitere mit der
Websitenutzung und der Internetnutzung verbundene Dienstleistungen
gegenüber dem Websitebetreiber zu erbringen. Die im Rahmen von
Google Analytics von Ihrem Browser übermittelte IP-Adresse wird
nicht mit anderen Daten von Google zusammengeführt.</P>
<H2 CLASS="western" STYLE="margin-top: 0in; background: #ffffff; border: none; padding: 0in; line-height: 100%">
Datenschutzerklärung für die Nutzung von Facebook-Plugins
(Like-Button)</H2>
<P STYLE="margin-bottom: 0in; background: #ffffff; border: none; padding: 0in">
Auf unseren Apps sind Plugins des sozialen Netzwerks Facebook,
Anbieter Facebook Inc., 1 Hacker Way, Menlo Park, California 94025,
USA, integriert. Die Facebook-Plugins erkennen Sie an dem
Facebook-Logo oder dem &quot;Like-Button&quot; (&quot;Gefällt mir&quot;)
auf unserer App. Eine übersicht über die Facebook-Plugins finden
Sie hier: <A HREF="http://developers.facebook.com/docs/plugins/"><FONT COLOR="#0000ee"><U>http://developers.facebook.com/docs/plugins/</U></FONT></A>.</P>
<P STYLE="margin-bottom: 0in; background: #ffffff; border: none; padding: 0in">
Wenn Sie unsere Apps besuchen, wird über das Plugin eine direkte
Verbindung zwischen Ihrem Browser und dem Facebook-Server
hergestellt. Facebook erhält dadurch die Information, dass Sie mit
Ihrer IP-Adresse unsere App besucht haben. Wenn Sie den Facebook
&quot;Like-Button&quot; anklicken während Sie in Ihrem
Facebook-Account eingeloggt sind, können Sie die Inhalte unserer
Apps auf Ihrem Facebook-Profil verlinken. Dadurch kann Facebook den
Besuch unserer Apps Ihrem Benutzerkonto zuordnen. Wir weisen darauf
hin, dass wir als Anbieter der Apps keine Kenntnis vom Inhalt der
übermittelten Daten sowie deren Nutzung durch Facebook erhalten.
Weitere Informationen hierzu finden Sie in der Datenschutzerklärung
von Facebook unter <A HREF="http://de-de.facebook.com/policy.php"><FONT COLOR="#0000ee"><U>http://de-de.facebook.com/policy.php</U></FONT></A>.</P>
<P STYLE="margin-bottom: 0in; background: #ffffff; border: none; padding: 0in">
Wenn Sie nicht wünschen, dass Facebook den Besuch unserer Apps Ihrem
Facebook-Nutzerkonto zuordnen kann, loggen Sie sich bitte aus Ihrem
Facebook-Benutzerkonto aus.</P>
<H2 CLASS="western" STYLE="background: #ffffff; border: none; padding: 0in">
Auskunft, Löschung, Sperrung</H2>
<P STYLE="margin-bottom: 0in; background: #ffffff; border: none; padding: 0in">
Sie haben jederzeit das Recht auf unentgeltliche Auskunft über Ihre
gespeicherten personenbezogenen Daten, deren Herkunft und Empfänger
und den Zweck der Datenverarbeitung sowie ein Recht auf Berichtigung,
Sperrung oder Löschung dieser Daten. Hierzu sowie zu weiteren Fragen
zum Thema personenbezogene Daten können Sie sich jederzeit unter der
im Impressum angegebenen Adresse an uns wenden.</P>
<H2 CLASS="western" STYLE="background: #ffffff; border: none; padding: 0in">
Widerspruch Werbe-Mails</H2>
<P STYLE="margin-bottom: 0in; background: #ffffff; border: none; padding: 0in">
Der Nutzung von im Rahmen der Impressumspflicht veröffentlichten
Kontaktdaten zur Übersendung von nicht ausdrücklich angeforderter
Werbung und Informationsmaterialien wird hiermit widersprochen. Die
Betreiber der Apps behalten sich ausdrücklich rechtliche Schritte im
Falle der unverlangten Zusendung von Werbeinformationen, etwa durch
Spam-E-Mails, vor.</P>
<H2 CLASS="western"><A NAME="_80d6y456m49x"></A>Änderung der
Datenschutzbestimmungen</H2>
<P STYLE="margin-bottom: 0in">Wir behalten uns das Recht vor, diese
Datenschutzbedingungen jederzeit unter Beachtung der geltenden
Datenschutzgesetze zu verändern.</P>
<P STYLE="margin-bottom: 0in; background: #ffffff; border: none; padding: 0in">
<BR>
</P>
            """,
            onLinkTap: (url, context, attributes, _) {
              launch(url);
            },
          ),
        ),
      ),
    );
  }
}
