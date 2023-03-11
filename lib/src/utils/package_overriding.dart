import 'package:tokens_manager/tokens_manager.dart';
import 'package:fresh_dio/fresh_dio.dart' as fresh;

AuthenticationStatus overrideFreshAuthStatus(
    fresh.AuthenticationStatus status) {
  switch (status) {
    case fresh.AuthenticationStatus.initial:
      return AuthenticationStatus.initial;
    case fresh.AuthenticationStatus.unauthenticated:
      return AuthenticationStatus.unauthenticated;
    case fresh.AuthenticationStatus.authenticated:
      return AuthenticationStatus.authenticated;
  }
}
