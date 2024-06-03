import 'package:client/src/data/models/vehicle.type.model.dart';
import 'package:dio/dio.dart';

abstract class VehicleTypeRepository {
  Future<List<VehicleType>> getVehicleTypes();
}

class VehicleTypeRepositoryImpl implements VehicleTypeRepository {
  final Dio _dio;

  VehicleTypeRepositoryImpl(this._dio);

  @override
  Future<List<VehicleType>> getVehicleTypes() async {
    try {
      final response = await _dio.get('/api/vehicleTypes');
      final data = response.data as List;
      return data.map((e) => VehicleType.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }
}
