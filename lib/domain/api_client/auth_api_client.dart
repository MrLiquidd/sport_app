import 'dart:convert';

import 'package:travel_app/configuration/configuration.dart';

import 'network_client.dart';


class AuthApiClient {
  final _networkClient = NetworkClient();

  Future<String> auth({
    required String username,
    required String password,
  }) async {
    // final token = await _makeToken();
    // final validToken = await _validateUser(
    //   username: username,
    //   password: password,
    //   requestToken: token,
    // );
    final sessionId = await _makeSession(username: username, password: password);
    return sessionId;
  }

  Future<String> _makeToken() async {
    String parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap['request_token'] as String;
      return token;
    }

    final result = _networkClient.get(
      '/authentication/token/new',
      parser,
      <String, dynamic>{'api_key': Configuration.apiKey},
    );
    return result;
  }

  Future<String> _validateUser({
    required String username,
    required String password,
    required String requestToken,
  }) async {
    String parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap['request_token'] as String;
      return token;
    }

    final parameters = <String, dynamic>{
      'username': username,
      'password': password,
      'request_token': requestToken,
    };
    final result = _networkClient.post(
      '/authentication/token/validate_with_login',
      parameters,
      parser,
      <String, dynamic>{'api_key': Configuration.apiKey},
    );
    return result;
  }

  Future<String> _makeSession({
    String? requestToken,
    String? username,
    String? password
  }) async {
    String parser(dynamic json) {
      // final jsonMap = json as Map<String, dynamic>;
      // final sessionId = jsonMap['Logged in user session'] as String;
      final sessionId = json.split(':')[1];
      return sessionId;
    }

    final parameters = <String, dynamic>{
      'username': username,
      'password': password
    };

    final result = _networkClient.get(
      '/user/login?',
       parser,
      parameters
    );

    return result;
  }
}
