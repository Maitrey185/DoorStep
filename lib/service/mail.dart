import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

sendMail(String email) async {
  String username = 'doorstep050@gmail.com';
  String password = 'doorstep@1234';

  // ignore: deprecated_member_use
  final smtpServer = gmail(username, password);
  // Use the SmtpServer class to configure an SMTP server:
  // final smtpServer = SmtpServer('smtp.domain.com');
  // See the named arguments of SmtpServer for further configuration
  // options.

  // Create our message.
  final message = Message()
    ..from = Address(username, '@DoorStep')
    ..recipients.add('maitreypatil185@gmail.com')
    ..subject = 'Order placed successfully'
    ..text = 'text'
    ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('Message not sent.');
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }
  // DONE


}