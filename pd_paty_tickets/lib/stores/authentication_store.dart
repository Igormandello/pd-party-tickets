import 'dart:convert';

import 'package:flutter_flux/flutter_flux.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart';

class AuthRequest {
  AuthRequest({ this.username, this.password});
  final String username;
  final String password;
}

class AuthenticationStore extends Store {
  AuthenticationStore() {
    triggerOnAction(login, (AuthRequest request) => _login(request.username, request.password));
    triggerOnAction(setToken, (String token) => this._token = token);
    triggerOnAction(setLoading, (bool loading) => this._loading = loading);
  }

  _login(String username, String password) async {
    setLoading(true);

    String url = "${GlobalConfiguration().getString("API_HOST")}/v1/auth/login";
    Response res = await post(url, headers: {
        "Content-Type": "application/json"
      },
      body: json.encode({
        "username": username,
        "password": password
      })
    );

    if (res.statusCode == 200) {
      setToken(res.body);
    }

    setLoading(false);
  }

  String _token;
  String get token => _token;

  bool _loading = false;
  bool get loading => _loading;
}

final StoreToken authStoreToken = new StoreToken(new AuthenticationStore());

final Action<AuthRequest> login = new Action<AuthRequest>();
final Action<String> setToken = new Action<String>();
final Action<bool> setLoading = new Action<bool>();