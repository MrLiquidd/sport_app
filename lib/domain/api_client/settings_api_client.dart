import 'package:intl/intl.dart';
import 'package:travel_app/domain/data_providers/session_data_provider.dart';
import 'network_client.dart';

class SettingsApiClient{
  final _networkClient = NetworkClient();
  final _sessionDataProvider = SessionDataProvider();

  Future<bool> postChangePhone(String phone) async{
    final accessId = await _sessionDataProvider.getAccessJWTToken();

    bool parser(dynamic json){
      final jsonMap = json as Map<String, dynamic>;
      final status = jsonMap['result'] as bool;
      return status;
    }

    final parameters = <String, dynamic>{
      'mobile': phone,
    };

    final result = await _networkClient.post(
      '/update/mobile/',
      parameters,
      parser,
      accessId,
    );
    return result;


  }
  Future<bool> postChangeGender(String gender) async{
    final accessId = await _sessionDataProvider.getAccessJWTToken();

    bool parser(dynamic json){
      final jsonMap = json as Map<String, dynamic>;
      print(jsonMap);
      final status = jsonMap['result'] as bool;
      return status;
    }
    final parameters = <String, dynamic>{
      'gender': gender,
    };

    final result = await _networkClient.post(
      '/update/gender/',
      parameters,
      parser,
      accessId,
    );
    return result;


  }
  Future<bool> postChangeBirth(String borndate) async{
    final accessId = await _sessionDataProvider.getAccessJWTToken();

    bool parser(dynamic json){
      final jsonMap = json as Map<String, dynamic>;
      final status = jsonMap['result'] as bool;
      return status;
    }

    final parameters = <String, dynamic>{
      'born_date': borndate,
    };

    final result = await _networkClient.post(
      '/update/borndate/',
      parameters,
      parser,
      accessId,
    );
    return result;


  }
  Future<bool> postChangePassword(String newPassword, String oldPassword) async{
    final accessId = await _sessionDataProvider.getAccessJWTToken();

    bool parser(dynamic json){
      final jsonMap = json as Map<String, dynamic>;
      final status = jsonMap['result'] as bool;
      return status;
    }

    final parameters = <String, dynamic>{
      'old_password': oldPassword,
      'new_password': newPassword
    };

    final result = await _networkClient.post(
      '/update/change-password/',
      parameters,
      parser,
      accessId,
    );
    return result;


  }
}