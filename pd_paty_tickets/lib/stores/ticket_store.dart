import 'dart:convert';

import 'package:flutter_flux/flutter_flux.dart';
import 'package:http/http.dart';
import '../utils/http_middleware.dart';

class Ticket {
  Ticket({ this.id, this.date });
  final String id;
  final DateTime date;

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return new Ticket(
      id: json['id'],
      date: DateTime.parse(json['date'])
    );
  }
}

class TicketStore extends Store {
  TicketStore() {
    triggerOnAction(addTicket, (String ticketId) {
      this._addTicket(ticketId);
    });

    triggerOnAction(addAnonymousTicket, (payload) {
      this._addAnonymousTicket();
    });

    triggerOnAction(removeTicket, (String ticketId) {
      this._removeTicket(ticketId);
    });

    triggerOnAction(setTickets, (List<Ticket> tickets) {
      this._tickets.clear();
      this._tickets.addAll(tickets);
    });

    triggerOnAction(waitForTickets, (payload) {
      this._fetchTickets(true);
    });
  }

  fetchTickets() async {
    await this._fetchTickets(false);
  }

  _fetchTickets(bool wait) async {
    Response res = await http.get('/v1/ticket${ wait ? '?wait' : ''}');
    while (res.statusCode == 503) {
      res = await http.get('/v1/ticket?wait');
    }

    if (res.statusCode == 200) {
      List rawTickets = json.decode(res.body) as List;
      List<Ticket> tickets = rawTickets.map((item) => Ticket.fromJson(item)).toList();

      setTickets(tickets);
      waitForTickets();
    }
  }

  _addTicket(String ticketId) async {
    await http.post('/v1/ticket', body: { 'id': ticketId });
  }

  _addAnonymousTicket() async {
    await http.post('/v1/ticket/anonymous');
  }

  _removeTicket(String ticketId) async {
    await http.delete('/v1/ticket/' + ticketId);
  }

  final List<Ticket> _tickets = <Ticket>[];
  List<Ticket> get tickets =>
      new List<Ticket>.unmodifiable(_tickets);
}

final StoreToken ticketStoreToken = new StoreToken(new TicketStore());

final Action<List<Ticket>> setTickets = new Action<List<Ticket>>();
final Action<String> addTicket = new Action<String>();
final Action<String> removeTicket = new Action<String>();
final Action addAnonymousTicket = new Action();
final Action waitForTickets = new Action();