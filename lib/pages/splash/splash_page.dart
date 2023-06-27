import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_brain_app/core/helpers/router_config.dart';
import 'package:trip_brain_domain/trip_brain_domain.dart';
import 'package:trip_brain_ui/trip_brain_ui.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) => SplashLayout(
        authIO: context.read<AuthCubit>(),
        onExistUser: (user) => context.pushHome(),
        onNewUser: () => context.pushAuth(),
      );

  // Future<(User? user, bool foundUser)> _checkSavedUser() async {
  //   try {
  //     final accessToken = await widget.localRepository.getAccessToken();

  //     final user =
  //         await widget.authenticator.accessTokenLogin(accessToken ?? '');

  //     return (user, true);
  //   } catch (e) {
  //     return (null, false);
  //   }
  // }
}
