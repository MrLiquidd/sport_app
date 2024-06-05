import 'dart:convert';

import 'package:travel_app/configuration/configuration.dart';
import 'package:travel_app/domain/data_providers/session_data_provider.dart';

import 'network_client.dart';

class AuthApiClient {
  final _networkClient = NetworkClient();

  Future<(String, String)> auth({
    required String username,
    required String password,
  }) async {
    final (String, String) tokens = await _validateUser(
      username: username,
      password: password,
    );
    return tokens;
  }

  Future<String> signup({
    required String email,
    required String password1,
    required String password2,
  }) async {
      String parser(dynamic json){
        final jsonMap = json as Map<String, dynamic>;
        final status = jsonMap['status'] as String;
        return status;
      }
      final parameters = <String, dynamic>{
        'email': email,
        'password1': password1,
        'password2': password2,
      };

      final result = _networkClient.post(
        '/signup/',
        parameters,
        parser,
      );

      return result;
  }


  Future<(String, String)> _validateUser({
    required String username,
    required String password,
  }) async {
    (String, String) parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final access = jsonMap['access'] as String;
      final refresh = jsonMap['refresh'] as String;
      final (String, String)  tokens = (access, refresh);
      return tokens;
    }

    final parameters = <String, dynamic>{
      'email': username,
      'password': password,
    };
    final result = _networkClient.post(
      '/login/',
      parameters,
      parser,
    );
    return result;
  }

  // Future<void> refreshToken() async {
  //
  //   String parser(dynamic json) {
  //     final jsonMap = json as Map<String, dynamic>;
  //     final refresh = jsonMap['access'] as String;
  //     return refresh;
  //   }
  //
  //   final refreshToken = await _sessionDataProvider.getRefreshId();
  //
  //   if (refreshToken == null) {
  //     // Handle the case where there is no refresh token
  //     return;
  //   }
  //
  //   final parameters = <String, dynamic>{
  //     'refresh': refreshToken,
  //   };
  //
  //   try {
  //     final result = await _networkClient.refreshToken(
  //       '/refresh/',
  //       parameters,
  //       parser,
  //     );
  //
  //     await _sessionDataProvider.setAccessId(result);
  //   } catch (e) {
  //     // Handle errors appropriately, possibly rethrowing or logging them
  //     print('Error refreshing token: $e');
  //   }
  // }
}

