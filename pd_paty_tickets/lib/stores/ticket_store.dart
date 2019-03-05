import 'package:flutter_flux/flutter_flux.dart';

class Ticket {
  Ticket({ this.id, this.date });
  final String id;
  final DateTime date;
}

class TicketStore extends Store {
  TicketStore() {
    triggerOnAction(addTicket, (Ticket ticket) {
      if (!this._tickets.any((ticket) => ticket.id == ticket.id)) {
        this._tickets.add(ticket);
        this._tickets.sort((a, b) => a.id.compareTo(b.id));
      }
    });
  }

  final List<Ticket> _tickets = <Ticket>[];
  List<Ticket> get tickets =>
      new List<Ticket>.unmodifiable(_tickets);
}

final StoreToken ticketStoreToken = new StoreToken(new TicketStore());

final Action<Ticket> addTicket = new Action<Ticket>();