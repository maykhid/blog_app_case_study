import 'package:http/http.dart' as http;

import '../../../../model/error/exception.dart';

abstract class ResponseHandler<T> {
  /// [T] data response type
  T handleResponse(T response);
}

class HttpResponseHandler implements ResponseHandler<http.Response> {
  /// [http.Response] is the return type and [handleResponse]'s parameter
  @override
  handleResponse(response) {
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return response;
    } else if (response.statusCode >= 400 && response.statusCode <= 499) {
      throw ClientException(response.body, response.statusCode);
    } else {
      throw ServerException(response.body, response.statusCode);
    }
  }
}
