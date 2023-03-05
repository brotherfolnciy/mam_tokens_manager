import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:logger/logger.dart';
import 'package:tokens_manager/tokens_manager.dart';

const FlutterSecureStorage _flutterSecureStorage = FlutterSecureStorage();

class TokensStorage extends TokenStorage<OAuth2Token> {
  TokensStorage({required TokenType type}) : _type = type;

  final Logger _logger = Logger();

  final TokenType _type;

  TokenType get type => _type;

  late final String _refreshTokenKey = tokensTypeWithKeyNames[_type]!;

  String? _accessToken;

  // Это поле служит только для форматирования о отображения логов
  // об изменении refresh токена, не использовать в иных операциях
  String? _refreshToken;

  void setMockInitialValues(Map<String, String> values) {
    // ignore: invalid_use_of_visible_for_testing_member
    FlutterSecureStorage.setMockInitialValues(values);
  }

  @override
  Future<void> delete() async {
    if (_accessToken?.isEmpty ?? false) _accessToken = null;

    await _flutterSecureStorage.delete(key: _refreshTokenKey);

    _logger.i(
        '$type | Access: ${_accessToken?.substring(0, 30)} and Refresh: $_refreshToken tokens was deleted');
  }

  @override
  Future<OAuth2Token?> read() async {
    final refreshToken =
        await _flutterSecureStorage.read(key: _refreshTokenKey);

    return OAuth2Token(
        accessToken: _accessToken ?? '', refreshToken: refreshToken);
  }

  @override
  Future<void> write(token) async {
    _accessToken = token.accessToken;
    _refreshToken = token.refreshToken;

    if (_accessToken?.isEmpty ?? false) _accessToken = null;

    await _flutterSecureStorage.write(
        key: _refreshTokenKey, value: token.refreshToken);

    _logger.i(
        '$type | Access: ${_accessToken?.substring(0, 30)} and Refresh: $_refreshToken tokens was writed');
  }
}
