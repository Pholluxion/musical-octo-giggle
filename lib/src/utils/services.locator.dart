import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:client/src/data/repositories/auth.repository.dart';
import 'package:client/src/data/repositories/parking.repository.dart';
import 'package:client/src/data/repositories/spot.repository.dart';
import 'package:client/src/data/repositories/vehicle.type.repository.dart';
import 'package:client/src/data/services/auth.service.dart';
import 'package:client/src/data/services/parking.service.dart';
import 'package:client/src/data/services/spot.service.dart';
import 'package:client/src/data/services/vehicle.type.service.dart';

const kBaseURL = 'https://gopark-core.up.railway.app';

final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerLazySingletonAsync<SharedPreferences>(
    () => SharedPreferences.getInstance(),
  );
  await locator.isReady<SharedPreferences>();
  locator.registerSingleton<Dio>(
    Dio(
      BaseOptions(
        baseUrl: kBaseURL,
        headers: {
          'Content-Type': 'application/json',
          'accept': 'application/json',
        },
      ),
    ),
  );

  /// Registering Repositories
  locator.registerSingleton<AuthenticationRepository>(
    AuthenticationRepositoryImpl(
      locator<Dio>(),
    ),
  );

  locator.registerSingleton<ParkingRepository>(
    ParkingRepositoryImpl(
      locator<Dio>(),
    ),
  );

  locator.registerSingleton<SpotRepository>(
    SpotRepositoryImpl(
      locator<Dio>(),
    ),
  );

  locator.registerSingleton<VehicleTypeRepository>(
    VehicleTypeRepositoryImpl(
      locator<Dio>(),
    ),
  );

  /// Registering Services
  locator.registerSingleton<AuthenticationService>(
    AuthenticationServiceImpl(
      locator<AuthenticationRepository>(),
    ),
  );

  locator.registerSingleton<ParkingService>(
    ParkingServiceImpl(
      locator<ParkingRepository>(),
    ),
  );

  locator.registerSingleton<SpotService>(
    SpotServiceImpl(
      locator<SpotRepository>(),
    ),
  );

  locator.registerSingleton<VehicleTypeService>(
    VehicleTypeServiceImpl(
      locator<VehicleTypeRepository>(),
    ),
  );
}
