import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tokens_manager/tokens_manager.dart';
import 'package:logger/logger.dart';
import 'package:tokens_manager/src/storages/storages.dart';

class TokensManager {
  static final Logger _logger = Logger();

  ///
  /// Установка тестовых моков
  ///
  @visibleForTesting
  static void setMockInitialValues(Map<String, String> values) {
    // ignore: invalid_use_of_visible_for_testing_member
    FlutterSecureStorage.setMockInitialValues(values);
  }

  static Future<Tokens?> Function(String)? _refreshTokenCallback;

  static set refreshTokenCallback(Future<Tokens?> Function(String)? callback) =>
      _refreshTokenCallback = callback;

  static Future setTokens({
    required String tokenName,
    required Tokens tokens,
  }) async {
    await getFreshByTokenName(tokenName).setToken(tokens);
  }

  static Future clearTokens({
    required String tokenName,
  }) async {
    await getFreshByTokenName(tokenName).clearToken();
  }

  static Future revokeTokens({
    required String tokenName,
  }) async {
    await getFreshByTokenName(tokenName).revokeToken();
  }

  static Future<Tokens?> getTokens({
    required String tokenName,
  }) async {
    return await _getTokensStorageByTokenName(tokenName).read();
  }

  static Future<Tokens> _refreshToken(Tokens? tokens, Dio dio) async {
    try {
      final refreshedTokens =
          await _refreshTokenCallback?.call(tokens!.refreshToken!);

      String? refreshedAccessToken = refreshedTokens?.accessToken;
      if (refreshedAccessToken?.isEmpty ?? false) refreshedAccessToken = null;

      _logger.i(
          'Refresh token: ${tokens!.refreshToken!} was refreshed and get Access: ${refreshedAccessToken?.substring(0, 30)}');

      return refreshedTokens!;
    } catch (e) {
      return const Tokens();
    }
  }

  static Map<String, String> _getTokenHeader(Tokens token) {
    return {
      'Authorization': 'Bearer ${token.accessToken}',
    };
  }

  static Fresh<Tokens> getFreshByTokenName(String tokenName) {
    if (_freshes.containsKey(tokenName)) {
      return _freshes[tokenName]!;
    } else {
      final fresh = Fresh<Tokens>(
        tokenHeader: _getTokenHeader,
        tokenStorage: _getTokensStorageByTokenName(tokenName),
        refreshToken: _refreshToken,
      );
      _freshes[tokenName] = fresh;
      return fresh;
    }
  }

  static TokensStorage _getTokensStorageByTokenName(String tokenName) {
    if (_storages.containsKey(tokenName)) {
      return _storages[tokenName]!;
    } else {
      final storage = TokensStorage(
        tokenName: tokenName,
      );
      _storages[tokenName] = storage;
      return storage;
    }
  }

  static final Map<String, TokensStorage> _storages = {};

  static final Map<String, Fresh<Tokens>> _freshes = {};
}
