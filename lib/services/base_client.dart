import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'app_exceptions.dart';

class BaseClient {
  Future<dynamic> get(String baseUrl, String api) async {
    var uri = Uri.parse(baseUrl + api);
    try {
      var response = await http.get(uri).timeout(const Duration(seconds: 10));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException(
          message: 'No Internet Connection', url: uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          message: 'Api Not Responded in Time', url: uri.toString());
    }
  }

  Future<dynamic> post(String baseUrl, String api, mapData) async {
    var uri = Uri.parse(baseUrl + api);
    //var payload = json.encode(mapData);
    try {
      var response = await http.post(uri,
          body: mapData); //.timeout(Duration(seconds: 10));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException(
          message: 'No Internet Connection', url: uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          message: 'Api Not Responded in Time', url: uri.toString());
    }
  }

  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);
        return responseJson;
      case 201:
        //var responseJson = utf8.decode(response.bodyBytes);
        var responseJson = json.decode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(
            message: utf8.decode(response.bodyBytes),
            url: response.request!.url.toString());
      case 401:
      case 403:
      case 404:
        var data = utf8.decode(response.bodyBytes);
        //print(data.substring(13, data.length - 3));
        throw UnAutthorizedException(
            message: data.substring(13, data.length - 3),
            //jsonDecode(response.body),
            url: response.request!.url.toString());
      case 500:
      default:
        throw FetchDataException(
            message: 'Error Occured with code: ${response.statusCode}',
            url: response.request!.url.toString());
    }
  }
}
