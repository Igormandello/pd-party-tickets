import 'package:flutter/material.dart';
import 'app.dart';

void main() => runApp(PDPartyTickets());

class PDPartyTickets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PDP Tickets',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: App(title: 'PD Party Tickets'),
    );
  }
}