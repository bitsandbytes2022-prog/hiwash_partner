import 'package:get_storage/get_storage.dart';

class LocalStorage {
  final GetStorage _storage = GetStorage();

  final String _tokenKey = 'auth_token';
  final String _userIdKey = 'user_id';
  final String _customerIdKey = 'customer_id';
  final String _scannedQrCodeKey = 'scanned_qr_code';

  Future<void> saveToken(String token) async {
    await _storage.write(_tokenKey, token);
  }

  Future<void> saveUserId(String id) async {
    await _storage.write(_userIdKey, id);
  }
  String? getToken() {
    return _storage.read(_tokenKey);
  }

  String? getUserId() {
    return _storage.read(_userIdKey);
  }


Future<void> saveScannedQrCode(String qrCode) async {
  await _storage.write(_scannedQrCodeKey, qrCode);
}

String? getScannedQrCode() => _storage.read(_scannedQrCodeKey);
String? getCustomerId() => _storage.read(_customerIdKey);
  Future<void> removeToken() async {
    await _storage.remove(_tokenKey);
    await _storage.remove(_userIdKey);
    await _storage.remove(_customerIdKey);

  }
}
