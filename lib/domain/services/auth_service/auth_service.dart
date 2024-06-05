import 'package:travel_app/domain/data_providers/session_data_provider.dart';
import 'package:travel_app/ui/navigation/main_navigation.dart';

class AuthService {

  final _sessionDataProvider = SessionDataProvider();

  Future<void> logout() async {
    await _sessionDataProvider.deleteAccessId();
    await _sessionDataProvider.deleteRefreshId();
    await _sessionDataProvider.deleteAccountId();
  }
}