import 'package:dio/dio.dart';

import 'package:client/src/data/models/spot.model.dart';

abstract class SpotRepository {
  Future<List<Spot>> getSpots(String token);
  Future<List<Spot>> getSpotsByParkingId(int parkingId, String token);
  Future<Spot> getSpotByVehiclePlate(String licensePlate, String token);
  Future<void> createSpot(Spot spot, String token);
  Future<Spot> updateSpot(Spot spot, String token);
  Future<void> deleteSpot(int spotId, String token);
}

class SpotRepositoryImpl implements SpotRepository {
  final Dio _dio;

  SpotRepositoryImpl(this._dio);

  @override
  Future<List<Spot>> getSpots(String token) async {
    try {
      final response = await _dio.get(
        '/api/spots',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      final data = response.data as List;
      return data.map((e) => Spot.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> createSpot(Spot spot, String token) async {
    try {
      await _dio.post(
        '/api/spots',
        data: spot.toJson(),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteSpot(int spotId, String token) {
    try {
      return _dio.delete(
        '/api/spots/$spotId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Spot> getSpotByVehiclePlate(String licensePlate, String token) async {
    try {
      final response = await _dio.get(
        '/api/spots/license/$licensePlate',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return Spot.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Spot>> getSpotsByParkingId(int parkingId, String token) {
    try {
      return _dio
          .get(
        '/api/spots/parking/$parkingId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      )
          .then((response) {
        final data = response.data as List;
        return data.map((e) => Spot.fromJson(e)).toList();
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Spot> updateSpot(Spot spot, String token) {
    try {
      return _dio
          .put(
        '/api/spots/${spot.id}',
        data: spot.toJson(),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      )
          .then((response) {
        return Spot.fromJson(response.data);
      });
    } catch (e) {
      rethrow;
    }
  }
}
