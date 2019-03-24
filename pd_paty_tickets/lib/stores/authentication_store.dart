import 'package:flutter_flux/flutter_flux.dart';
import 'package:http/http.dart';
import '../utils/http_middleware.dart';

class AuthRequest {
  AuthRequest({ this.username, this.password});
  final String username;
  final String password;
}

class AuthenticationStore extends Store {
  AuthenticationStore() {
    triggerOnAction(login, (AuthRequest request) => _login(request.username, request.password));
    triggerOnAction(setLoading, (bool loading) => this._loading = loading);
    triggerOnAction(setToken, (String token) {
      this._token = token;
      updateContractToken(token);
    });
  }

  _login(String username, String password) async {
    setLoading(true);
    Response res = await http.post('/v1/auth/login',
      body: {
        'username': username,
        'password': password
      }
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