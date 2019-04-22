import 'package:flutter/material.dart';
import 'package:pd_paty_tickets/screens/login.dart';
import 'package:pd_paty_tickets/screens/home.dart';

class App extends StatelessWidget {
  App({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PD Party Tickets',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Login(),
        '/home': (context) => Home(),
      }
    );
}
}