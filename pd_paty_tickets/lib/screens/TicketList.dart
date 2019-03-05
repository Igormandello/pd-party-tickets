import 'package:flutter/material.dart';

class TicketList extends StatelessWidget {
  final items = List<int>.generate(10000, (i) => i + 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemBuilder: (context, index) => ListTile(
          leading: Icon(Icons.person),
          title: Text("Index ${items[index]}")
        ),
        separatorBuilder: (context, index) => Divider(
          color: Colors.black26,
        ),
        itemCount: items.length,
      )
    );
  }
}