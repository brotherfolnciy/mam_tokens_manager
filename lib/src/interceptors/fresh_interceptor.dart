import 'package:fresh_dio/fresh_dio.dart';
import 'package:tokens_manager/tokens_manager.dart';

Fresh createFreshInterceptor(TokenType type) => Fresh.oAuth2(
      refreshToken: (token, httpClient) async {
        try {
          final refreshedTokens = await TokensManager.refreshToken(
              (await TokensManager.storageByType(type).read())!.refreshToken!);
          return OAuth2Token(
              accessToken: refreshedTokens!.accessToken!,
              refreshToken: refreshedTokens.refreshToken);
        } catch (e) {
          TokensManager.onTokenRefreshError(type);
          return const OAuth2Token(accessToken: '');
        }
      },
      tokenStorage: TokensManager.storageByType(type),
    );
