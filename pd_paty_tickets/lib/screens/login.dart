import 'package:flutter/material.dart';
import 'package:flutter_flux/flutter_flux.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new LoginState();
}

class LoginState extends State<Login>
  with StoreWatcherMixin<Login> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.1, 0.3, 0.5, 0.7],
          colors: [
            Colors.deepPurple[800],
            Colors.deepPurple[700],
            Colors.deepPurple[600],
            Colors.deepPurple[500],
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Welcome",
            style: Theme.of(context).textTheme.display1.copyWith(color: Colors.white)
          ),
          Card(
            elevation: 6,
            margin: EdgeInsets.all(16),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Username"
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Password"
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: OutlineButton(
                      child: Text("Login"),
                      color: Theme.of(context).primaryColor,
                      textColor: Theme.of(context).primaryColor,
                      onPressed: () => null
                    ),
                  )
                ],
              ),
            )
          ),
        ]
      )
    );
  }
}