import 'dart:async';

import 'package:fresh_dio/fresh_dio.dart' hide AuthenticationStatus;
import 'enums/enums.dart';
import 'package:logger/logger.dart';
import 'package:tokens_manager/src/models/tokens.dart';
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

  ///
  /// Изменение статуса авторизации для какого-либо токена
  ///
  static void changeAuthenticationStatus({
    required TokenType type,
    required AuthenticationStatus status,
  }) =>
      _getAuthenticationStatusControllerByType(type).add(status);

  static Future<Tokens?> Function(String)? _refreshTokenCallback;

  static set refreshTokenCallback(Future<Tokens?> Function(String)? callback) =>
      _refreshTokenCallback = callback;

  ///
  /// Рефреш токена
  ///

  static Future<Tokens?> refreshToken(String refreshToken) async {
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

  static final TokensStorage _armTokensStorage =
      TokensStorage(type: TokenType.arm);

  static final StreamController<AuthenticationStatus>
      _armAuthenticationStatusController = StreamController();

  ///
  /// Токен Client
  ///

  static final TokensStorage _lpTokensStorage =
      TokensStorage(type: TokenType.lp);

  static final StreamController<AuthenticationStatus>
      _lpAuthenticationStatusController = StreamController();

  ///
  /// Токен OAuth
  ///

  static final TokensStorage _oAuthTokensStorage =
      TokensStorage(type: TokenType.oAuth);

  static final StreamController<AuthenticationStatus>
      _oAuthAuthenticationStatusController = StreamController();

  ///
  /// Токен Anonymous
  ///

  static final TokensStorage _anonimTokensStorage =
      TokensStorage(type: TokenType.anonim);

  static final StreamController<AuthenticationStatus>
      _anonimAuthenticationStatusController = StreamController();

  ///
  /// Токен SearchElemento
  ///

  static final TokensStorage _searchTokensStorage =
      TokensStorage(type: TokenType.search);

  static final StreamController<AuthenticationStatus>
      _searchAuthenticationStatusController = StreamController();

  // Tokens Storages

  static final List<TokensStorage> _storages = [
    _armTokensStorage,
    _lpTokensStorage,
    _oAuthTokensStorage,
    _anonimTokensStorage,
    _searchTokensStorage
  ];

  // Auth Status Controllers Storages

  static final _authenticationStatusControllers = {
    TokenType.arm: _armAuthenticationStatusController,
    TokenType.lp: _lpAuthenticationStatusController,
    TokenType.oAuth: _oAuthAuthenticationStatusController,
    TokenType.anonim: _anonimAuthenticationStatusController,
    TokenType.search: _searchAuthenticationStatusController,
  };

  ///
  /// Получение экземпляра TokensStorage по типу токена
  ///

  static TokensStorage storageByType(TokenType type) =>
      _storages.where((e) => e.type == type).first;

  ///
  /// Получение экземпляра Stream<AuthenticationStatus> по типу токена
  ///
  static Stream<AuthenticationStatus> getAuthenticationStatusByType(
          TokenType type) =>
      _getAuthenticationStatusControllerByType(type).stream.asBroadcastStream();

  ///
  /// Получение экземпляра StreamController<AuthenticationStatus> по типу токена
  ///
  static StreamController<AuthenticationStatus>
      _getAuthenticationStatusControllerByType(
    TokenType type,
  ) =>
          _authenticationStatusControllers[type]!;
}
