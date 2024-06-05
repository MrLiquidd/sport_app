import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class _Keys {
  static const access = 'access';
  static const refresh = 'refresh';
  static const accountId = 'account_id';
}

class SessionDataProvider {
  static const _secureStorage = FlutterSecureStorage();

  Future<String?> getAccessId() async => await _secureStorage.read(key: _Keys.access);
  Future<String?> getRefreshId() async => await _secureStorage.read(key: _Keys.refresh);
  Future<String?> getAccountId() async => await _secureStorage.read(key: _Keys.accountId);

  Future<void> setAccessId(String value) {
    return _secureStorage.write(key: _Keys.access, value: value);
  }
  Future<void> setRefreshId(String value) {
    return _secureStorage.write(key: _Keys.refresh, value: value);
  }


  Future<void> deleteAccessId() {
    return _secureStorage.delete(key: _Keys.access);
  }
  Future<void> deleteRefreshId() {
    return _secureStorage.delete(key: _Keys.refresh);
  }

  Future<void> setAccountId(String value) {
    return _secureStorage.write(
      key: _Keys.accountId,
      value: value.toString(),
    );
  }

  Future<void> deleteAccountId() {
    return _secureStorage.delete(key: _Keys.accountId);
  }
}
