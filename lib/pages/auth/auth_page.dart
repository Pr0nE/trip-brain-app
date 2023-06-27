import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_brain_app/core/helpers/router_config.dart';
import 'package:trip_brain_domain/trip_brain_domain.dart';

import 'package:trip_brain_ui/trip_brain_ui.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      authIO: context.read<AuthCubit>(),
      onSuccessLogin: (_) => context.pushHome(),
    );
  }
}
