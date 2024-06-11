import 'package:travel_app/domain/api_client/network_client.dart';
import 'package:travel_app/domain/data_providers/session_data_provider.dart';
import 'package:travel_app/domain/model/user_info_model/user_info_model.dart';
import 'package:travel_app/domain/model/user_model/user_model.dart';

class AccountApiClient {
  final _networkClient = NetworkClient();
  final _sessionDataProvider = SessionDataProvider();

  Future<String> getAccountInfo(
      String accessId,
      ) async {
    String parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = jsonMap['id'] as String;
      return result;
    }

    final parameters = <String, dynamic>{
      'accessId': accessId,
    };

    final result = _networkClient.get(
      '/account',
      parameters,
      parser,
    );
    return result;
  }


  Future<UserModel> getUserSettingsInfo(
      ) async {
    final accessId = await _sessionDataProvider.getAccessJWTToken();

    UserModel parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = UserModel.fromJson(jsonMap);
      return response;
    }
    final parameters = <String, dynamic>{
      'accessId': accessId!,
    };

    final result = _networkClient.get(
      '/account',
      parameters,
      parser,
    );
    return result;
  }

  Future<UserInfoModel> getUserInfo(
      ) async {
    final accountId = await  _sessionDataProvider.getAccountId();
    final accessId = await _sessionDataProvider.getAccessJWTToken();

    UserInfoModel parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = UserInfoModel.fromJson(jsonMap);
      return response;
    }
    final parameters = <String, dynamic>{
      'accessId': accessId!,
    };

    final result = _networkClient.get(
        '/user-info/$accountId',
        parameters,
        parser,
      );
    return result;
  }

  Future<bool> deleteAccount() async{
    final accountId = await  _sessionDataProvider.getAccountId();
    final accessId = await _sessionDataProvider.getAccessJWTToken();

    bool parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final status = jsonMap['status'] as bool;
      return status;
    }
    final parameters = <String, dynamic>{
    };

    final result = _networkClient.post(
      '/soft-delete/$accountId',
      parameters,
      parser,
      accessId
    );
    return result;
  }
}
