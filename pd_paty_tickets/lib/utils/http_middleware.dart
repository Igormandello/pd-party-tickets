import 'package:http_middleware/http_middleware.dart';

class AuthenticationContract extends MiddlewareContract {
  String _token;

  AuthenticationContract({ String token }) {
    this._token = token;
  }

  @override
  interceptRequest({ RequestData data }) {
    data.headers['Content-Type'] = 'application/json';
    if (_token != null)
      data.headers['Authorization'] = 'Bearer $_token';
  }

  @override
  void interceptResponse({ ResponseData data }) {}
}

updateContractToken (String token) {
  http = HttpWithMiddleware.build(middlewares: [ AuthenticationContract(token: token) ]);
}

HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [ AuthenticationContract() ]);
