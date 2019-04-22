import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'home/scan_ticket.dart';
import 'home/ticket_list.dart';
import '../stores/authentication_store.dart';
import './login.dart';

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
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  final storage = new FlutterSecureStorage();
                  storage.delete(key: LOGIN_JWT_KEY);
                  setToken(null);

                  Navigator.of(context).popUntil(ModalRoute.withName('/'));
                }
              )
            )
          ],
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