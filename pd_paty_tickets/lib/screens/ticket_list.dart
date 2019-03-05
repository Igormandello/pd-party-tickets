import 'package:flutter/material.dart';
import 'package:flutter_flux/flutter_flux.dart';
import 'package:intl/intl.dart';
import '../stores/ticket_store.dart';

class TicketList extends StatefulWidget {


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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemBuilder: (context, index) => ListTile(
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
