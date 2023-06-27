import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:trip_brain_data/trip_brain_data.dart';

import 'package:trip_brain_app/core/helpers/router_config.dart';
import 'package:trip_brain_domain/trip_brain_domain.dart';

class TripBrainApp extends StatelessWidget {
  const TripBrainApp({super.key});

  @override
  Widget build(BuildContext context) => Provider<APIClient>(
        create: (context) => APIClient(
          //host: '23.94.120.138',
          grpcClientInfo: GRPClientInfo(
              host: Platform.isAndroid ? '10.0.2.2' : 'localhost', port: 5051),
          //host: Platform.isAndroid ? '45.142.122.232' : 'localhost',
          //  port: 5051),
        ),
        child: Provider<AppLocalRepository>(
          create: (context) => AppLocalRepository(storage: SecureStorage()),
          child: Provider<AuthRepository>(
            create: (context) =>
                AuthRepository(apiClient: context.read<APIClient>()),
            child: Provider(
              create: (context) => AuthCubit(
                  authenticator: context.read<AuthRepository>(),
                  storage: context.read<AppLocalRepository>()),
              child: Provider<TravelSuggestionRepository>(
                create: (context) => TravelSuggestionRepository(
                  authProvider: context.read<AuthCubit>(),
                  client: context.read<APIClient>(),
                  cacheManager: MapCacheManager(),
                ),
                child: MaterialApp.router(
                  theme: ThemeData(
                      brightness: Brightness.dark,
                      textTheme: GoogleFonts.robotoTextTheme()),
                  // TOODO: theme:
                  // TODO: localizationsDelegates:
                  builder: (context, child) => child ?? ErrorWidget('Error'),
                  //  Provider<ImageRepository>(
                  //   create: (context) => ImageRepository(context.read<APIClient>()),
                  //   child: Provider<DialogManager>(
                  //     create: (context) => DialogManager(context),
                  //     child: ,
                  //   ),
                  // ),
                  routerConfig: appRouterConfig,
                ),
              ),
            ),
          ),
        ),
      );
}
