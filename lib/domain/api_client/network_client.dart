import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:travel_app/configuration/configuration.dart';
import 'package:travel_app/domain/api_client/auth_api_client.dart';
import 'package:travel_app/domain/data_providers/session_data_provider.dart';

import 'api_client_exception.dart';

class NetworkClient {

  final _sessionDataProvider = SessionDataProvider();

  Uri _makeUri(String path, [Map<String, dynamic>? parameters]) {
    final uri = Uri.parse('${Configuration.host}$path');
    if (parameters != null) {
      return uri.replace(queryParameters: parameters);
    } else {
      return uri;
    }
  }

  Future<T> get<T>(
      String path,
      Map<String, dynamic> bodyParameters,
      T Function(dynamic json) parser, [
        Map<String, dynamic>? parameters,
      ]) async {
    try {
      final url = _makeUri(path, parameters);
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'charset': 'utf-8',
          'Authorization': 'JWT ${bodyParameters['accessId']}',
        },
      );

      var jsonResponse = json.decode(response.body);
      final isValid = _validateResponse(response, jsonResponse);
      if (!isValid) {
        await refreshToken(); // Ждем обновления токена
        response = await http.get(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'charset': 'utf-8',
            'Authorization': 'JWT ${bodyParameters['token']}',
          },
        );
        jsonResponse = json.decode(response.body);
      }
      final result = parser(jsonResponse);
      return result;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.network);
    } on ApiClientException {
      rethrow;
    } catch (_) {
      throw ApiClientException(ApiClientExceptionType.other);
    }
  }


  Future<T> post<T>(
      String path,
      Map<String, dynamic> bodyParameters,
      T Function(dynamic json) parser, [
        Map<String, dynamic>? urlParameters,
      ]) async {
    try {
      final url = _makeUri(path, urlParameters);
      var response = await http.post(url,
          body: bodyParameters);
      var jsonResponse = json.decode(response.body);
      final isValid = _validateResponse(response, jsonResponse);
      if (isValid) {
        final result = parser(jsonResponse);
        return result;
      }else{
        refreshToken();
        response = await http.post(url,
            body: bodyParameters);
        jsonResponse = json.decode(response.body);
        final result = parser(jsonResponse);
        return result;
      }

      // final HttpClientRequest request = await _client.postUrl(url);
      // request.headers.contentType = ContentType.json;
      // request.write(jsonEncode(bodyParameters));
      //final response = await request.close();
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.network);
    } on ApiClientException {
      rethrow;
    } catch (e) {
      throw ApiClientException(ApiClientExceptionType.other);
    }
  }

  bool _validateResponse(http.Response response, dynamic json) {
    if (response.statusCode == 401) {
      return false;
      // final dynamic status = json['status_code'];
      // final code = status is int ? status : 0;
      // if (code == 30) {
      //   throw ApiClientException(ApiClientExceptionType.auth);
      // } else if (code == 3) {
      //   throw ApiClientException(ApiClientExceptionType.sessionExpired);
      // } else {
      //   throw ApiClientException(ApiClientExceptionType.other);
      // }
    }
    return true;
  }

  Future<void> refreshToken() async {

    String parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final refresh = jsonMap['access'] as String;
      return refresh;
    }

    final refreshToken = await _sessionDataProvider.getRefreshId();

    if (refreshToken == null) {
      // Handle the case where there is no refresh token
      return;
    }

    final parameters = <String, dynamic>{
      'refresh': refreshToken,
    };

    try {
      final result = await post(
        '/refresh/',
        parameters,
        parser,
      );

      await _sessionDataProvider.setAccessId(result);
    } catch (e) {
      // Handle errors appropriately, possibly rethrowing or logging them
      print('Error refreshing token: $e');
    }
  }
}

extension HttpClientResponseJsonDecode on HttpClientResponse {
  Future<dynamic> jsonDecode() async {
    return transform(utf8.decoder).toList().then((value) {
      final result = value.join();
      return result;
    }).then<dynamic>((v) => json.decode(v));
  }
}
