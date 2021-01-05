import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

void main() {
  runApp(MailApp());
}

class MailApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mail Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MailHomePage(title: 'Mail Demo Page'),
    );
  }
}

class MailHomePage extends StatefulWidget {
  MailHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MailHomePageState createState() => _MailHomePageState();
}

class _SmtpServerOption {
  int port = 25;
  String host = '192.168.11.33';
  bool ignoreBadCertificate = true;
  bool ssl = false;
  bool allowInsecure = true;
  String username = '';
  String password = '';
  String xoauth2Token = '';
}

class _Mail {
  String from = 'admin@domain';
  String to = 'office@domain';
  String cc = '';
  String subject = 'test mail';
  String text = 'test mail body';
  String attachment = '';
}

class _MailHomePageState extends State<MailHomePage> {
  var _mail = new _Mail();
  var _option = new _SmtpServerOption();

  void _sendMail() async {
    final smtpServer = new SmtpServer(_option.host,
        port: _option.port,
        allowInsecure: _option.allowInsecure,
        ignoreBadCertificate: _option.ignoreBadCertificate);
    print('smtp:' + smtpServer.allowInsecure.toString());
    final message = Message()
      ..from = Address(_mail.from)
      ..recipients.add(_mail.to)
      ..subject = _mail.subject
      ..text = _mail.text;

    try {
      final sendReport =
          await send(message, smtpServer, timeout: Duration(seconds: 15));
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.' + e.message);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              initialValue: _option.host,
              decoration: InputDecoration(
                labelText: 'SMTP Address',
              ),
              onChanged: (value) {
                setState(() {
                  _option.host = value;
                });
              },
            ),
            TextFormField(
              initialValue: _option.port.toString(),
              decoration: InputDecoration(
                labelText: 'Port',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: (value) {
                setState(() {
                  _option.port = int.parse(value);
                });
              },
            ),
            TextFormField(
              initialValue: _option.username,
              decoration: InputDecoration(
                labelText: 'User',
              ),
              onChanged: (value) {
                setState(() {
                  _option.username = value;
                });
              },
            ),
            TextFormField(
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              initialValue: _option.password,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              onChanged: (value) {
                setState(() {
                  _option.password = value;
                });
              },
            ),
            TextFormField(
              initialValue: _mail.to,
              decoration: InputDecoration(
                labelText: 'Mail To',
              ),
              onChanged: (value) {
                setState(() {
                  _mail.to = value;
                });
              },
            ),
            TextFormField(
              initialValue: _mail.from,
              decoration: InputDecoration(
                labelText: 'Mail From',
              ),
              onChanged: (value) {
                setState(() {
                  _mail.from = value;
                });
              },
            ),
            TextFormField(
              initialValue: _mail.subject,
              decoration: InputDecoration(
                labelText: 'Mail Subject',
              ),
              onChanged: (value) {
                setState(() {
                  _mail.subject = value;
                });
              },
            ),
            TextFormField(
              initialValue: _mail.text,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                labelText: 'Mail Text',
              ),
              onChanged: (value) {
                setState(() {
                  _mail.text = value;
                });
              },
            ),
            SwitchListTile(
              value: _option.ssl,
              title: Text(
                "use SSL",
              ),
              onChanged: (bool value) {
                setState(() {
                  _option.ssl = value;
                });
              },
            ),
            SwitchListTile(
              value: _option.allowInsecure,
              title: Text(
                "allow Insecure",
              ),
              onChanged: (bool value) {
                setState(() {
                  _option.allowInsecure = value;
                });
              },
            ),
            SwitchListTile(
              value: _option.ignoreBadCertificate,
              title: Text(
                "ignore Bad Certificate",
              ),
              onChanged: (bool value) {
                setState(() {
                  _option.ignoreBadCertificate = value;
                });
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMail,
        tooltip: 'Send',
        child: Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
