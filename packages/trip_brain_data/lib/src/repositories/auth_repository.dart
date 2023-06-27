import 'package:google_sign_in/google_sign_in.dart';

import 'package:trip_brain_data/src/api/api_client.dart';
import 'package:trip_brain_data/src/generated/gpt.pbgrpc.dart' hide User;

import 'package:trip_brain_domain/trip_brain_domain.dart';

class AuthRepository implements Authenticator {
  AuthRepository({
    required APIClient apiClient,
  }) : authClient = AuthClient(apiClient.grpcChannel);

  final AuthClient authClient;

  @override
  Future<User> googleLogin() async {
    try {
      final GoogleSignInAccount? account = await GoogleSignIn().signIn();

      if (account == null) {
        // TODO: auht exception
        throw Exception('Auth Error');
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
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<User> _authorizeSocialUser({
    required String idToken,
    required AuthProvider provider,
  }) async {
    switch (provider) {
      case AuthProvider.google:
        final response = await authClient.socialAuthorize(
          SocialAuthorizeRequest(
              token: idToken,
              provider: switch (provider) { AuthProvider.google => 'google' }),
        );

        return User(
          id: response.user.id,
          name: response.user.name,
          token: response.user.token,
        );
    }
  }

  @override
  Future<User> accessTokenLogin(String token) async {
    final response = await authClient.tokenAuthorize(
      TokenAuthorizeRequest(token: token),
    );

    return User(
      id: response.user.id,
      name: response.user.name,
      token: response.user.token,
    );
  }
}
