import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:qrcode_reader/qrcode_reader.dart';
import 'package:flutter_flux/flutter_flux.dart';
import '../../stores/ticket_store.dart';

class ScanTicket extends StatefulWidget {
  ScanTicket({ Key key }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScanTicketState();
}

class _ScanTicketState extends State<ScanTicket>
    with StoreWatcherMixin<ScanTicket> {
  AudioCache audioCache = new AudioCache();
  TicketStore ticketStore;

  @override
  void initState() {
    super.initState();

    ticketStore = listenToStore(ticketStoreToken);
    ticketStore.fetchTickets();
  }

  void _addPerson(String id) {
    addTicket(id);
  }

  Future _scan() async {
    String ticketId = await new QRCodeReader()
                       .setAutoFocusIntervalInMs(100)
                       .setForceAutoFocus(true)
                       .setTorchEnabled(true)
                       .scan();

    if (ticketId == null) return;

    bool duplicated = ticketStore.tickets.any((ticket) => ticketId == ticket.id);
    if (duplicated) {
      audioCache.play("alert.mp3");

      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("What the actual fuck???"),
            content: new Text(
              "That ticket number is already at the party 😠 😤, better call Kadu."
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Understandable, have a nice day."),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text("Added ticket: $ticketId"),
      ));

      this._addPerson(ticketId);
    }
  }

  String buildPeopleCountText() {
    if (ticketStore.tickets.length == 0)
      return 'no one';

    String ret = ticketStore.tickets.length.toString();
    if (ticketStore.tickets.length == 1)
      return ret + ' person';

    return ret + ' people';
  }

  String buildDescriptionText() {
    if (ticketStore.tickets.length == 0)
      return 'is in the party =(';

    String ret = ' in the party =)';
    if (ticketStore.tickets.length == 1)
      return 'is' + ret;

    return 'are' + ret;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Column(
              children: <Widget>[
                Text(
                    'So far',
                    style: Theme.of(context).textTheme.headline
                ),
                Padding(
                  padding: EdgeInsets.only(top: 6, bottom: 12),
                  child: Text(
                      buildPeopleCountText(),
                      style: Theme.of(context).textTheme.display2
                  ),
                ),
                Text(
                    buildDescriptionText(),
                    style: Theme.of(context).textTheme.headline
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 25),
            ),
            Text(
              'Click the button bellow to Scan a ticket.',
              textAlign: TextAlign.center,
            )
          ]
        )
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _scan,
        label: Text('Scan QR Code'),
        icon: Icon(Icons.camera)
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
