import 'package:client/src/data/models/parking.model.dart';
import 'package:client/src/data/repositories/parking.repository.dart';

abstract class ParkingService {
  Future<List<Parking>> getParkings();
}

class ParkingServiceImpl implements ParkingService {
  final ParkingRepository _parkingRepository;

  ParkingServiceImpl(this._parkingRepository);

  @override
  Future<List<Parking>> getParkings() {
    return _parkingRepository.getParkings();
  }
}
