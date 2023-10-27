import 'dart:convert';

import 'package:blog_app_case_study/core/data/model/error/exception.dart';
import 'package:http/http.dart' as http;

extension StringX on String {
  String get capitalizeFirstLetter {
    if (isEmpty) {
      return this; // Return the original string if it's empty.
    }
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}


extension HttpResponseX on http.Response {
  dynamic get handleResponse {
    if (statusCode == 200) {
      return jsonDecode(body);
    } else if (statusCode >= 400 || statusCode <= 404) {
      throw ClientException(
        'Client Exception: $reasonPhrase',
        statusCode,
      );
    }
    throw ServerException(
      'Server Exception: $reasonPhrase',
      statusCode,
    );
  }
}
