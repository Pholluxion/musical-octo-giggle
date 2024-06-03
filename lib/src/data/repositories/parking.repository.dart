import 'package:client/src/data/models/parking.model.dart';
import 'package:dio/dio.dart';

abstract class ParkingRepository {
  Future<List<Parking>> getParkings();
}

class ParkingRepositoryImpl implements ParkingRepository {
  final Dio _dio;

  ParkingRepositoryImpl(this._dio);

  @override
  Future<List<Parking>> getParkings() async {
    try {
      final response = await _dio.get('/api/parkings');
      final data = response.data as List;
      return data.map((e) => Parking.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }
}
