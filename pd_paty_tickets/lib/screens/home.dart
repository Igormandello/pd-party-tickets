import 'package:flutter/material.dart';
import 'home/scan_ticket.dart';
import 'home/ticket_list.dart';

class Home extends StatelessWidget {
  Home({ Key key }) : super(key: key);

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
          title: Text("PD Party Tickets"),
        ),
        body: TabBarView(
          children: [
            ScanTicket(),
            TicketList(),
          ],
        ),
      ),
    );
  }
}