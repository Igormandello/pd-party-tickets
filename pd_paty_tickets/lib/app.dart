import 'package:flutter/material.dart';
import 'package:pd_paty_tickets/screens/home.dart';

class App extends StatelessWidget {
  App({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Home(),
    );
  }
}