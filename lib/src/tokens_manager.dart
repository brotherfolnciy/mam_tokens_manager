import 'dart:async';

import 'package:fresh_dio/fresh_dio.dart';
import 'package:logger/logger.dart';
import 'package:tokens_manager/src/models/tokens.dart';
import 'package:tokens_manager/src/storages/storages.dart';

import 'enums/enums.dart';

class TokensManager {
  static Logger logger = Logger();

  static final StreamController<TokenType> _tokenRefreshErrorStreamController =
      StreamController<TokenType>.broadcast();

  ///
  /// Приходят данные, когда где-то произошла ошибка рефреша какого-либо токена
  ///
  static Stream<TokenType> get tokenRefreshErrorStream =>
      _tokenRefreshErrorStreamController.stream.asBroadcastStream();

  ///
  /// Должен вызываться, когда произошла ошибка рефреша токена
  /// В аргументе передается тип токена
  ///
  static void onTokenRefreshError(TokenType type) {
    logger.i('$type token was logout');

    _tokenRefreshErrorStreamController.add(type);
  }

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

    logger.i(
        'Refresh token: $refreshToken was refreshed and get Access: ${refreshedAccessToken?.substring(0, 30)}');

    return refreshedTokens;
  }

  ///
  /// Получение экземпляра OAuthTokens с помощью access и refresh токенов
  ///

  static OAuth2Token convertTokenStringsToOAuthTokens(
      String accessToken, String? refreshToken) {
    return OAuth2Token(accessToken: accessToken, refreshToken: refreshToken);
  }

  ///
  /// Токен ARM
  ///

  static final TokensStorage armTokensStorage =
      TokensStorage(type: TokenType.arm);

  ///
  /// Токен Client
  ///

  static final TokensStorage lpTokensStorage =
      TokensStorage(type: TokenType.lp);

  ///
  /// Токен OAuth
  ///

  static final TokensStorage oAuthTokensStorage =
      TokensStorage(type: TokenType.oAuth);

  ///
  /// Токен Anonymous
  ///

  static final TokensStorage anonimTokensStorage =
      TokensStorage(type: TokenType.anonim);

  ///
  /// Токен SearchElemento
  ///

  static final TokensStorage searchTokensStorage =
      TokensStorage(type: TokenType.search);

  static final List<TokensStorage> _storages = [
    armTokensStorage,
    lpTokensStorage,
    oAuthTokensStorage,
    anonimTokensStorage,
    searchTokensStorage
  ];

  ///
  /// Получение экземпляра TokensStorage по типу токена
  ///

  static TokensStorage storageByType(TokenType type) =>
      _storages.where((e) => e.type == type).first;
}
