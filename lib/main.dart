import 'package:client/src/bloc/parking.cubit.dart';
import 'package:client/src/bloc/spot.cubit.dart';
import 'package:client/src/bloc/vehicle.type.cubit.dart';
import 'package:client/src/data/services/parking.service.dart';
import 'package:client/src/data/services/spot.service.dart';
import 'package:client/src/data/services/vehicle.type.service.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:client/src/bloc/authentication.cubit.dart';
import 'package:client/src/bloc/printer.cubit.dart';
import 'package:client/src/data/services/auth.service.dart';
import 'package:client/src/pages/home.page.dart';
import 'package:client/src/pages/login.page.dart';
import 'package:client/src/pages/printer.page.dart';
import 'package:client/src/utils/services.locator.dart' as sl;
import 'package:client/src/utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sl.setupLocator();
  runApp(const GoParkApp());
}

class GoParkApp extends StatelessWidget {
  const GoParkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PrinterCubit(
            sl.locator<SharedPreferences>(),
          ),
        ),
        BlocProvider(
          create: (context) => AuthenticationCubit(
            sl.locator<AuthenticationService>(),
            sl.locator<SharedPreferences>(),
          )..loginFromCache(),
        ),
        BlocProvider(
          create: (context) => SpotCubit(
            sl.locator<SpotService>(),
            sl.locator<SharedPreferences>(),
          ),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => ParkingCubit(
            sl.locator<ParkingService>(),
          )..getParkings(),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => VehicleTypeCubit(
            sl.locator<VehicleTypeService>(),
          )..getVehicleTypes(),
        ),
      ],
      child: const _MateApp(),
    );
  }
}

class _MateApp extends StatelessWidget {
  const _MateApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GoPark',
      routes: routes,
      theme: themeData,
      initialRoute: '/login',
    );
  }
}

final routes = {
  '/': (context) => const HomePage(),
  '/login': (context) => const LoginPage(),
  '/printer': (context) => const PrinterPage(),
};
