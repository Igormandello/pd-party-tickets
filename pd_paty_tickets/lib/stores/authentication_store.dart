import 'package:flutter_flux/flutter_flux.dart';
import 'package:http/http.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../utils/http_middleware.dart';

class AuthRequest {
  AuthRequest({ this.username, this.password});
  final String username;
  final String password;
}

class AuthenticationStore extends Store {
  final _storage = new FlutterSecureStorage();

  AuthenticationStore() {
    triggerOnAction(login, (AuthRequest request) => _login(request.username, request.password));
    triggerOnAction(setLoading, (bool loading) => this._loading = loading);
    triggerOnAction(setToken, (String token) {
      this._token = token;
      updateContractToken(token);
    });

    this._verifyToken();
  }

  _verifyToken() async {
    String value = await _storage.read(key: LOGIN_JWT_KEY);
    if (value == null) return;

    setLoading(true);
    updateContractToken(value);

    Response res = await http.post('/v1/auth/verify');
    if (res.statusCode != 200) {
      updateContractToken(null);
      await _storage.delete(key: LOGIN_JWT_KEY);
    } else {
      setToken(value);
    }

    setLoading(false);
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
      await _storage.write(key: LOGIN_JWT_KEY, value: res.body);
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

const String LOGIN_JWT_KEY = "LOGIN_JWT";