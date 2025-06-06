import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_storage/get_storage.dart';

class LocalStorage {
  final GetStorage _storage = GetStorage();

  final String _tokenKey = 'auth_token';
  final String _userIdKey = 'user_id';
  final String _customerIdKey = 'customer_id';
  final String _scannedQrCodeKey = 'scanned_qr_code';
  final  String _fcmToken = "fcmToken";
  final String _refreshTokenKey = 'refresh_token';



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
  saveFCMToken({var token}) {
    _storage.write(_fcmToken, token);
  }

  String getFCMToken() {
    return _storage.read(_fcmToken) ?? '';
  }


Future<void> saveScannedQrCode(String qrCode) async {
  await _storage.write(_scannedQrCodeKey, qrCode);
}

String? getScannedQrCode() => _storage.read(_scannedQrCodeKey);
String? getCustomerId() => _storage.read(_customerIdKey);


  // Refresh Token
  Future<void> saveRefreshToken(String token) async {
    await _storage.write(_refreshTokenKey, token);
  }

  String? getRefreshToken() {
    return _storage.read(_refreshTokenKey);
  }

  Future<void> removeToken() async {
    await _storage.remove(_tokenKey);
    await _storage.remove(_userIdKey);
    await _storage.remove(_customerIdKey);
    await _storage.remove(_fcmToken);
    await _storage.remove(_refreshTokenKey);
    await FirebaseMessaging.instance.deleteToken();


  }
}
