import 'package:bloc/bloc.dart';

import 'package:client/src/data/models/spot.model.dart';
import 'package:client/src/data/services/spot.service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpotCubit extends Cubit<SpotState> {
  final SpotService _spotService;
  final SharedPreferences _preferences;

  SpotCubit(this._spotService, this._preferences) : super(SpotState());

  String token = '';

  Future<void> getSpots() async {
    getToken();
    final spots = await _spotService.getSpots(token);
    emit(state.copyWith(spots: spots));
  }

  Future<void> createSpot(Spot spot) async {
    getToken();
    await _spotService.createSpot(spot, token);
  }

  void getToken() async {
    token = _preferences.getString('token') ?? '';
  }
}

class SpotState {
  final List<Spot> spots;

  SpotState({this.spots = const []});

  SpotState copyWith({List<Spot>? spots}) {
    return SpotState(spots: spots ?? this.spots);
  }
}
