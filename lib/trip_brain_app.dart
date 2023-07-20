import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:trip_brain_data/trip_brain_data.dart';

import 'package:trip_brain_app/core/router/router_config.dart';
import 'package:trip_brain_domain/trip_brain_domain.dart';

class TripBrainApp extends StatelessWidget {
  const TripBrainApp({super.key});

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider<APIClient>(
            create: (context) => APIClient(
              //host: '23.94.120.138',
              grpcClientInfo: GRPClientInfo(
                host: Platform.isAndroid ? '10.0.2.2' : 'localhost', port: 5051,
                // host: Platform.isAndroid ? '45.142.122.232' : 'localhost',
                // port: 5051,
              ),
            ),
          ),
          Provider<AppLocalRepository>(
            create: (context) => AppLocalRepository(storage: SecureStorage()),
          ),
          Provider<GeneralRepository>(
            create: (context) =>
                GeneralRepository(client: context.read<APIClient>()),
          ),
          Provider<AppModeCubit>(
            create: (context) =>
                AppModeCubit(serverPinger: context.read<GeneralRepository>()),
          ),
          Provider<AuthRepository>(
            create: (context) => AuthRepository(
              apiClient: context.read<APIClient>(),
              appModeProvider: context.read<AppModeCubit>(),
            ),
          ),
          Provider(
            create: (context) => AuthCubit(
              authenticator: context.read<AuthRepository>(),
              storage: context.read<AppLocalRepository>(),
            ),
          ),
          Provider(
            create: (context) => PlaceDetailsRepository(
              cacheManager: HiveCacheManager(),
              authProvider: context.read<AuthCubit>(),
              client: context.read<APIClient>(),
              appModeProvider: context.read<AppModeCubit>(),
            ),
          ),
          Provider<TravelSuggestionRepository>(
            create: (context) => TravelSuggestionRepository(
              authProvider: context.read<AuthCubit>(),
              client: context.read<APIClient>(),
              cacheManager: HiveCacheManager(),
              appModeProvider: context.read<AppModeCubit>(),
            ),
          ),
          Provider<PaymentManager>(
            create: (context) => PaymentRepository(
              client: context.read<APIClient>(),
              appModeProvider: context.read<AppModeCubit>(),
              authProvider: context.read<AuthCubit>(),
            ),
          ),
        ],
        child: MaterialApp.router(
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: const ColorScheme.dark(),
            brightness: Brightness.dark,
            textTheme: GoogleFonts.robotoTextTheme(ThemeData.dark().textTheme),
          ),
          // TODO: theme:
          // TODO: localizationsDelegates:
          builder: (context, child) => AppManager(child: child),
          routerConfig: appRouterConfig,
        ),
      );
}

class AppManager extends StatelessWidget {
  const AppManager({this.child, super.key});

  final Widget? child;

  @override
  Widget build(BuildContext context) => BlocListener<AppModeCubit, AppMode>(
        listener: (context, state) => ScaffoldMessenger.of(context)
            .showSnackBar(
                SnackBar(content: Text('App mode is now: ${state.name}'))),
        child: child,
      );
}
