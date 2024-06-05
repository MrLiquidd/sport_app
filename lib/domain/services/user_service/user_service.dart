import 'package:travel_app/domain/api_client/account_api_client.dart';
import 'package:travel_app/domain/api_client/auth_api_client.dart';
import 'package:travel_app/domain/data_providers/session_data_provider.dart';
import 'package:travel_app/domain/model/user_model.dart';



class UserService{
  final _accountApiClient = AccountApiClient();

  Future<UserInfo> userInfo() async {
    return _accountApiClient.getUserInfo();
  }
}