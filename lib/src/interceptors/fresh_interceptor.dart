import 'package:fresh_dio/fresh_dio.dart';
import 'package:tokens_manager/tokens_manager.dart';

Fresh createFreshInterceptor(
  TokenType type,
  TokenStorage<OAuth2Token> storage,
) =>
    Fresh.oAuth2(
      refreshToken: (token, httpClient) async {
        return (await TokensManager.refreshToken(token!.refreshToken!)) ??
            const OAuth2Token(accessToken: '');
      },
      tokenStorage: storage,
    );
