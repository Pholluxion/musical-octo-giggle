import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:client/src/data/models/parking.model.dart';
import 'package:client/src/data/services/parking.service.dart';

class ParkingCubit extends Cubit<ParkingState> {
  ParkingCubit(this._parkingService) : super(ParkingState());

  final ParkingService _parkingService;

  Future<void> getParkings() async {
    final parkings = await _parkingService.getParkings();
    emit(state.copyWith(parkings: parkings));
  }
}

class ParkingState {
  final List<Parking> parkings;

  ParkingState({this.parkings = const []});

  ParkingState copyWith({List<Parking>? parkings}) {
    return ParkingState(parkings: parkings ?? this.parkings);
  }
}
