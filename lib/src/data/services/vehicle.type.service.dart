import 'package:client/src/data/models/vehicle.type.model.dart';
import 'package:client/src/data/repositories/vehicle.type.repository.dart';

abstract class VehicleTypeService {
  Future<List<VehicleType>> getVehicleTypes();
}

class VehicleTypeServiceImpl implements VehicleTypeService {
  final VehicleTypeRepository _vehicleTypeRepository;

  VehicleTypeServiceImpl(this._vehicleTypeRepository);

  @override
  Future<List<VehicleType>> getVehicleTypes() {
    return _vehicleTypeRepository.getVehicleTypes();
  }
}
