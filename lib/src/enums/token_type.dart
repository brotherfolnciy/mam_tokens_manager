import 'package:tokens_manager/src/keys/keys.dart';

const Map<TokenType, String> tokensTypeWithKeyNames = {
  TokenType.arm: armRefreshTokenKey,
  TokenType.lp: memberLPRefreshTokenKey,
  TokenType.oAuth: oAuthRefreshTokenKey,
  TokenType.anonim: anonymousRefreshTokenKey,
  TokenType.search: searchElementoRefreshTokenKey,
};

enum TokenType {
  arm,
  lp,
  oAuth,
  anonim,
  search,
}
