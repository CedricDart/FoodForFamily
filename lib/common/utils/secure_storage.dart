import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

class SecureStorage {
  static const _accessToken = 'accessToken';
  static const _refreshToken = 'refreshToken';
  static const _deviceUniqueID = 'deviceUniqueID';
  static const _devicePublicKey = 'devicePublicKey';
  static const _devicePrivateKey = 'devicePrivateKey';

  final _storage = const FlutterSecureStorage();

  Future<String?> getAccessToken() {
    return _storage.read(key: _accessToken);
  }

  Future<void> setAccessToken(String accessToken) async {
    return _storage.write(key: _accessToken, value: accessToken);
  }

  Future<String?> getRefreshToken() {
    return _storage.read(key: _refreshToken);
  }

  Future<void> setRefreshToken(String refreshToken) async {
    return _storage.write(key: _refreshToken, value: refreshToken);
  }

  Future<String> getDeviceUniqueId() async {
    var _current = await _storage.read(key: _deviceUniqueID);
    if (_current != null) {
      return _current;
    } else {
      var v4 = const Uuid().v4();
      await _storage.write(key: _deviceUniqueID, value: v4);
      return v4;
    }
  }

  Future<String?> getDevicePrivateKey() {
    return _storage.read(key: _devicePrivateKey);
  }

  Future<void> setDevicePrivateKey(String privateKey) async {
    return _storage.write(key: _devicePrivateKey, value: privateKey);
  }

  Future<String?> getDevicePublicKey() {
    return _storage.read(key: _devicePublicKey);
  }

  Future<void> setDevicePublicKey(String publicKey) async {
    return _storage.write(key: _devicePublicKey, value: publicKey);
  }

  Future<void> cleanAuthorization() async {
    await _storage.delete(key: _accessToken);
    await _storage.delete(key: _refreshToken);
  }

  Future<void> cleanSecureKeys() async {
    await _storage.delete(key: _deviceUniqueID);
    await _storage.delete(key: _devicePrivateKey);
    await _storage.delete(key: _devicePublicKey);
  }

  Future<void> cleanAll() async {
    return await _storage.deleteAll();
  }
}
