import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:trip_brain_data/trip_brain_data.dart';

import 'package:trip_brain_app/core/router/router_config.dart';
import 'package:trip_brain_domain/trip_brain_domain.dart';
import 'package:trip_brain_ui/trip_brain_ui.dart';

class TripBrainApp extends StatelessWidget {
  const TripBrainApp({super.key});

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider<APIClient>(
            create: (context) => APIClient(
              //host: '23.94.120.138',
              grpcClientInfo: GRPClientInfo(
                //  host: Platform.isAndroid ? '10.0.2.2' : 'localhost', port: 5051,
                host: Platform.isAndroid ? '45.142.122.232' : 'localhost',
                port: 5051,
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
          Provider<AppSettingsCubit>(
            create: (context) => AppSettingsCubit(
                serverPinger: context.read<GeneralRepository>()),
          ),
          Provider<AuthRepository>(
            create: (context) => AuthRepository(
              apiClient: context.read<APIClient>(),
              appSettingsProvider: context.read<AppSettingsCubit>(),
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
              appSettingsProvider: context.read<AppSettingsCubit>(),
            ),
          ),
          Provider<TravelSuggestionRepository>(
            create: (context) => TravelSuggestionRepository(
              authProvider: context.read<AuthCubit>(),
              client: context.read<APIClient>(),
              cacheManager: HiveCacheManager(),
              appSettingsProvider: context.read<AppSettingsCubit>(),
            ),
          ),
          Provider<PaymentManager>(
            create: (context) => PaymentRepository(
              client: context.read<APIClient>(),
              appSettingsProvider: context.read<AppSettingsCubit>(),
              authProvider: context.read<AuthCubit>(),
            ),
          ),
        ],
        child: MaterialApp.router(
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            AppLocalization.delegate,
          ],
          supportedLocales: AppLocalization.delegate.supportedLocales,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: const ColorScheme.dark(),
            brightness: Brightness.dark,
            textTheme: GoogleFonts.robotoTextTheme(ThemeData.dark().textTheme),
          ),
          // TODO: theme:
          // TODO: localizationsDelegates:
          builder: (context, child) => AppManager(
            appSettingsManager: context.read<AppSettingsCubit>(),
            child: child ?? ErrorWidget('Empty App!'),
          ),
          routerConfig: appRouterConfig,
        ),
      );
}

class AppManager extends StatefulWidget {
  const AppManager(
      {required this.appSettingsManager, required this.child, super.key});

  final Widget child;
  final AppSettingsManager appSettingsManager;

  @override
  State<AppManager> createState() => _AppManagerState();
}

class _AppManagerState extends State<AppManager> {
  @override
  void didChangeDependencies() {
    widget.appSettingsManager
        .setAppLanguage(Localizations.localeOf(context).languageCode);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return StateStreamListener<AppMode>(
      stream: widget.appSettingsManager.appModeStream,
      onState: (appMode) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('App mode is now: ${appMode.name}'))),
      child: widget.child,
    );
  }
}
