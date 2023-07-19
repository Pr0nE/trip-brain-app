import 'package:google_sign_in/google_sign_in.dart';

import 'package:trip_brain_data/src/api/api_client.dart';
import 'package:trip_brain_data/src/exceptions/exception_mappers.dart';
import 'package:trip_brain_data/src/generated/gpt.pbgrpc.dart' hide User;

import 'package:trip_brain_domain/trip_brain_domain.dart';

class AuthRepository implements Authenticator {
  AuthRepository({
    required APIClient apiClient,
    required this.appModeProvider,
  }) : authClient = AuthClient(
          apiClient.grpcChannel,
          //  options: CallOptions(timeout: Duration(seconds: 5)),
        );

  final AuthClient authClient;
  final AppModeProvider appModeProvider;

  @override
  Future<User> googleLogin() async {
    try {
      final GoogleSignInAccount? account = await GoogleSignIn().signIn();

      if (account == null) {
        throw AppException(AppErrorType.needAuth);
      }

      final authentication = await account.authentication;
      final idToken = authentication.idToken;

      if (idToken == null) {
        throw Exception('Auth Error');
      }

      return _authorizeSocialUser(
        idToken: idToken,
        provider: AuthProvider.google,
      );
    } catch (error) {
      throw error.toAppException();
    }
  }

  Future<User> _authorizeSocialUser({
    required String idToken,
    required AuthProvider provider,
  }) async {
    try {
      switch (provider) {
        case AuthProvider.google:
          final response = await authClient.socialAuthorize(
            SocialAuthorizeRequest(
                token: idToken,
                provider: switch (provider) {
                  AuthProvider.google => 'google'
                }),
          );

          return User(
            id: response.user.id,
            name: response.user.name,
            token: response.user.token,
            balance: response.user.balance,
          );
      }
    } catch (error) {
      throw error.toAppException();
    }
  }

  @override
  Future<User> accessTokenLogin(String token) async {
    if (appModeProvider.isAppOffline) {
      return User(id: '', token: token, name: '', balance: 0);
    }

    try {
      final response =
          await authClient.tokenAuthorize(TokenAuthorizeRequest(token: token));

      return User(
        id: response.user.id,
        name: response.user.name,
        token: response.user.token,
        balance: response.user.balance,
      );
    } catch (error) {
      throw error.toAppException();
    }
  }
}
