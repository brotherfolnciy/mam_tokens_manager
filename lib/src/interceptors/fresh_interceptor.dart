import 'package:fresh_dio/fresh_dio.dart';
import 'package:tokens_manager/src/utils/utils.dart';
import 'package:tokens_manager/tokens_manager.dart';

Fresh createFreshInterceptor(TokenType type) {
  final fresh = Fresh.oAuth2(
    refreshToken: (token, httpClient) async {
      try {
        final refreshedTokens = await TokensManager.refreshToken(
          (await TokensManager.storageByType(type).read())!.refreshToken!,
        );
        return OAuth2Token(
          accessToken: refreshedTokens!.accessToken!,
          refreshToken: refreshedTokens.refreshToken,
        );
      } catch (e) {
        return const OAuth2Token(accessToken: '');
      }
    },
    tokenStorage: TokensManager.storageByType(type),
  );

  fresh.authenticationStatus.listen(
    (status) => TokensManager.changeAuthenticationStatus(
      type: type,
      status: overrideFreshAuthStatus(status),
    ),
  );

  return fresh;
}
