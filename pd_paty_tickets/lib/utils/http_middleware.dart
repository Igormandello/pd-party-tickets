import 'dart:convert';

import 'package:http_middleware/http_middleware.dart';
import 'package:global_configuration/global_configuration.dart';

class AuthenticationContract extends MiddlewareContract {
  String _token;

  AuthenticationContract({ String token }) {
    this._token = token;
  }

  @override
  interceptRequest({ RequestData data }) {
    data.url = GlobalConfiguration().getString('API_HOST') + data.url;

    if (data.body != null)
      data.body = json.encode(data.body);

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
