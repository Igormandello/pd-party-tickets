import 'package:flutter/material.dart';
import 'package:flutter_flux/flutter_flux.dart';
import 'package:intl/intl.dart';
import '../../stores/ticket_store.dart';

class TicketList extends StatefulWidget {
  TicketList({ Key key }) : super(key: key);

  @override
  State<StatefulWidget> createState() => new TicketListState();
}

class TicketListState extends State<TicketList>
    with StoreWatcherMixin<TicketList> {
  TicketStore ticketStore;

  @override
  void initState() {
    super.initState();
    
    ticketStore = listenToStore(ticketStoreToken);
  }

  void _showOptions(int index) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
      // return object of type Dialog
        return AlertDialog(
          title: new Text("Ticket ${ticketStore.tickets[index].id}"),
          content: new Text(
            "Hmm, I think that the only thing you could do is delete this ticket right?"
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("No, close."),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Sure, delete this."),
              onPressed: () {
                removeTicket(ticketStore.tickets[index].id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemBuilder: (context, index) => ListTile(
          onTap: () => _showOptions(index),
          leading: Icon(Icons.person),
          title: Text(
            ticketStore.tickets[index].id
          ),
          trailing: Text(
            new DateFormat.Hm().format(ticketStore.tickets[index].date),
            style: Theme.of(context).textTheme.caption,
          )
        ),
        separatorBuilder: (context, index) => Divider(
          color: Colors.black26,
        ),
        itemCount: ticketStore.tickets.length,
      )
    );
  }
}
