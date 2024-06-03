import 'package:client/src/data/models/spot.model.dart';
import 'package:client/src/data/repositories/spot.repository.dart';

abstract class SpotService {
  Future<List<Spot>> getSpots(String token);
  Future<List<Spot>> getSpotsByParkingId(int parkingId, String token);
  Future<Spot> getSpotByVehiclePlate(String licensePlate, String token);
  Future<void> createSpot(Spot spot, String token);
  Future<Spot> updateSpot(Spot spot, String token);
  Future<void> deleteSpot(int spotId, String token);
}

class SpotServiceImpl implements SpotService {
  final SpotRepository _spotRepository;

  SpotServiceImpl(this._spotRepository);

  @override
  Future<List<Spot>> getSpots(String token) {
    return _spotRepository.getSpots(token);
  }

  @override
  Future<void> createSpot(Spot spot, String token) {
    return _spotRepository.createSpot(spot, token);
  }

  @override
  Future<void> deleteSpot(int spotId, String token) {
    return _spotRepository.deleteSpot(spotId, token);
  }

  @override
  Future<Spot> getSpotByVehiclePlate(String licensePlate, String token) {
    return _spotRepository.getSpotByVehiclePlate(licensePlate, token);
  }

  @override
  Future<List<Spot>> getSpotsByParkingId(int parkingId, String token) {
    return _spotRepository.getSpotsByParkingId(parkingId, token);
  }

  @override
  Future<Spot> updateSpot(Spot spot, String token) {
    return _spotRepository.updateSpot(spot, token);
  }
}
