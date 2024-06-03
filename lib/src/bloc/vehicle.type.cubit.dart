import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:client/src/data/models/vehicle.type.model.dart';
import 'package:client/src/data/services/vehicle.type.service.dart';

class VehicleTypeCubit extends Cubit<VehicleTypeState> {
  final VehicleTypeService _vehicleTypeService;

  VehicleTypeCubit(this._vehicleTypeService) : super(VehicleTypeState());

  Future<void> getVehicleTypes() async {
    final vehicleTypes = await _vehicleTypeService.getVehicleTypes();
    emit(state.copyWith(vehicleTypes: vehicleTypes));
  }
}

class VehicleTypeState {
  final List<VehicleType> vehicleTypes;

  VehicleTypeState({this.vehicleTypes = const []});

  VehicleTypeState copyWith({List<VehicleType>? vehicleTypes}) {
    return VehicleTypeState(vehicleTypes: vehicleTypes ?? this.vehicleTypes);
  }
}
