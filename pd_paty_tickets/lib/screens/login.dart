import 'package:flutter/material.dart';
import 'package:flutter_flux/flutter_flux.dart';
import 'package:pd_paty_tickets/screens/home.dart';
import 'package:pd_paty_tickets/stores/authentication_store.dart';

class Login extends StatefulWidget {
  Login({ Key key }) : super(key: key);

  @override
  State<StatefulWidget> createState() => new LoginState();
}

class LoginState extends State<Login>
  with StoreWatcherMixin<Login> {
  AuthenticationStore authStore;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    authStore = listenToStore(authStoreToken, _onAuthChange);
  }

  void _requestLogin() {
    login(
      new AuthRequest(
        username: this.usernameController.text,
        password: this.passwordController.text
      )
    );
  }

  void _onAuthChange(store) {
    store = store as AuthenticationStore;
    if (store.token != null)
      Navigator.pushReplacement(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) => Home()
        )
      );
  }

  Widget _renderButtonChild() {
    if (authStore.loading) {
      return SizedBox(
        height: 18,
        width: 18,
        child: CircularProgressIndicator(
          strokeWidth: 2,
        )
      );
    }

    return Text("Login");
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
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      labelText: "Username"
                    ),
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password"
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Container(
                      width: 180,
                      child: OutlineButton(
                        borderSide: new BorderSide(color: Theme.of(context).primaryColor),
                        child: _renderButtonChild(),
                        color: Theme.of(context).primaryColor,
                        textColor: Theme.of(context).primaryColor,
                        onPressed: () => _requestLogin()
                      ),
                    )
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