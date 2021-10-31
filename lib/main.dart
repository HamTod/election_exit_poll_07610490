import 'package:election_exit_poll_07610490/pages/home_page.dart';
import 'package:election_exit_poll_07610490/pages/pollpage.dart';
import 'package:election_exit_poll_07610490/pages/result_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        '/result': (context) => const Result(),

      },
      home: const poll(),
    );
  }
}
