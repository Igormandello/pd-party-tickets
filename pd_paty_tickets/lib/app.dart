import 'package:flutter/material.dart';
import 'package:pd_paty_tickets/screens/home.dart';
import 'package:pd_paty_tickets/screens/login.dart';

class App extends StatelessWidget {
  App({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PD Party Tickets',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: Home(),
    );
}
}