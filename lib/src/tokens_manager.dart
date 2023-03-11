import 'dart:async';

import 'package:fresh_dio/fresh_dio.dart' hide AuthenticationStatus;
import 'package:tokens_manager/tokens_manager.dart';
import 'package:logger/logger.dart';
import 'package:tokens_manager/src/storages/storages.dart';

class TokensManager {
  static final Logger _logger = Logger();

  ///
  /// Установка тестовых моков
  ///
  static void setMockInitialValues(Map<String, String> values) {
    for (var e in _storages) {
      e.setMockInitialValues(values);
    }
  }

  static Future<OAuth2Token?> Function(String)? _refreshTokenCallback;

  static set refreshTokenCallback(
          Future<OAuth2Token?> Function(String)? callback) =>
      _refreshTokenCallback = callback;

  ///
  /// Рефреш токена
  ///

  static Future<OAuth2Token?> refreshToken(String refreshToken) async {
    final refreshedTokens = await _refreshTokenCallback?.call(refreshToken);

    String? refreshedAccessToken = refreshedTokens?.accessToken;
    if (refreshedAccessToken?.isEmpty ?? false) refreshedAccessToken = null;

    _logger.i(
        'Refresh token: $refreshToken was refreshed and get Access: ${refreshedAccessToken?.substring(0, 30)}');

    return refreshedTokens;
  }

  ///
  /// Получение экземпляра OAuthTokens с помощью access и refresh токенов
  ///

  static OAuth2Token convertTokensToTokensModel(
    String accessToken,
    String? refreshToken,
  ) {
    return OAuth2Token(accessToken: accessToken, refreshToken: refreshToken);
  }

  ///
  /// Токен ARM
  ///
  static final Fresh _armFresh =
      createFreshInterceptor(TokenType.arm, _armTokensStorage);

  static final TokensStorage _armTokensStorage =
      TokensStorage(type: TokenType.arm);

  ///
  /// Токен Client
  ///

  static final TokensStorage _lpTokensStorage =
      TokensStorage(type: TokenType.lp);

  ///
  /// Токен OAuth
  ///

  static final TokensStorage _oAuthTokensStorage =
      TokensStorage(type: TokenType.oAuth);

  ///
  /// Токен Anonymous
  ///

  static final TokensStorage _anonimTokensStorage =
      TokensStorage(type: TokenType.anonim);

  ///
  /// Токен SearchElemento
  ///

  static final TokensStorage _searchTokensStorage =
      TokensStorage(type: TokenType.search);

  // Tokens Storages

  static final List<TokensStorage> _storages = [
    _armTokensStorage,
    _lpTokensStorage,
    _oAuthTokensStorage,
    _anonimTokensStorage,
    _searchTokensStorage
  ];

  // Freshes

  static final _freshes = {
    TokenType.arm: _armFresh,
  };

  ///
  /// Получение экземпляра Fresh по типу токена
  ///
  static Fresh getFreshByType(
    TokenType type,
  ) =>
      _freshes[type]!;
}
