import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final nameCont = TextEditingController();
  final emailCont = TextEditingController();
  final subjectCont = TextEditingController();
  final messageCont = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Send Email'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            buildTextField(title: 'Name', controller: nameCont),
            buildTextField(title: 'Email', controller: emailCont),
            buildTextField(title: 'Subjecct', controller: subjectCont),
            buildTextField(title: 'Message', controller: messageCont),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () => sendEmail(
                    name: nameCont.text,
                    email: emailCont.text,
                    subject: subjectCont.text,
                    message: messageCont.text),
                child: Text('SEND'))
          ],
        ),
      );

  Future sendEmail({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    final serviceId = 'service_1cwqwpt';
    final templateId = 'template_1i08wn1';
    final userId = 'user_QJq7e6a5biy5mQMKpkqSs';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(url,
        headers: {
          'origin': 'http://localhost',
          'Content-Type': 'application/json'
        },
        body: json.encode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'user_name': name,
            'user_email': email,
            'to_email': 'mirokurokumi@gmail.com',
            'user_subject': subject,
            'user_message': message,
          }
        }));
    print(response.body);
  }

  Widget buildTextField(
          {required String title,
          required TextEditingController controller,
          int maxLines = 1}) =>
      Column(
        children: [
          Text(title),
          TextField(
            controller: controller,
          )
        ],
      );
}
