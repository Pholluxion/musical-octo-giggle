import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:client/src/data/models/user.model.dart';
import 'package:client/src/data/services/auth.service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final AuthenticationService _authenticationService;
  final SharedPreferences _preferences;

  AuthenticationCubit(this._authenticationService, this._preferences)
      : super(const Unauthenticated());

  Future<bool> login(String email, String password) async {
    emit(const Loading());
    final user = await _authenticationService.login(email, password);

    if (user != null) {
      emit(Authenticated(user));
      await _preferences.setBool('isAuthenticated', true);
      await _preferences.setString('email', email);
      await _preferences.setString('password', password);
      await _preferences.setString('token', user.accessToken);
      return true;
    } else {
      emit(const Unauthenticated());
      return false;
    }
  }

  Future<void> register(
    String name,
    String surname,
    String email,
    String password,
    String documentNumber,
  ) async {
    final isRegistered = await _authenticationService.register(
      name,
      surname,
      email,
      password,
      documentNumber,
    );

    if (isRegistered) {
      login(email, password);
    } else {
      emit(const Unauthenticated());
    }
  }

  Future<void> logout() async {
    await _preferences.clear();
    emit(const Unauthenticated());
  }

  Future<bool> isAuthenticated() async {
    return _preferences.getBool('isAuthenticated') ?? false;
  }

  Future<String> getEmail() async {
    return _preferences.getString('email') ?? '';
  }

  Future<String> getPassword() async {
    return _preferences.getString('password') ?? '';
  }

  Future<void> loginFromCache() async {
    if (!await isAuthenticated()) {
      emit(const Unauthenticated());
      return;
    }

    emit(const Loading());

    final email = await getEmail();
    final password = await getPassword();

    final user = await _authenticationService.login(email, password);

    if (user != null) {
      emit(Authenticated(user));
      await _preferences.setBool('isAuthenticated', true);
      await _preferences.setString('email', email);
      await _preferences.setString('password', password);
      await _preferences.setString('token', user.accessToken);
    } else {
      emit(const Unauthenticated());
    }
  }
}

abstract class AuthenticationState {
  const AuthenticationState();
}

class Authenticated extends AuthenticationState {
  final AuthenticationData user;

  const Authenticated(this.user);
}

class Unauthenticated extends AuthenticationState {
  const Unauthenticated();
}

class Loading extends AuthenticationState {
  const Loading();
}
