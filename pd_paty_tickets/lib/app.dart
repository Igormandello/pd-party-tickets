import 'package:flutter/material.dart';
import 'screens/HomePage.dart';
import 'screens/TicketList.dart';

class App extends StatelessWidget {
  App({ Key key, this.title }) : super(key: key);
  
  final String title;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.photo_camera)),
              Tab(icon: Icon(Icons.format_list_bulleted)),
            ],
          ),
          title: Text(this.title),
        ),
        body: TabBarView(
          children: [
            HomePage(),
            TicketList(),
          ],
        ),
      ),
    );
  }
}