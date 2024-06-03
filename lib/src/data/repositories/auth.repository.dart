import 'package:dio/dio.dart';

import 'package:client/src/data/models/user.model.dart';

abstract class AuthenticationRepository {
  Future<AuthenticationData?> login(
    String email,
    String password,
  );

  Future<bool> register(
    String name,
    String surname,
    String email,
    String password,
    String documentNumber,
  );
}

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final Dio _dio;

  AuthenticationRepositoryImpl(this._dio);

  @override
  Future<AuthenticationData?> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '/authenticate',
        data: {
          'email': email.trim(),
          'password': password.trim(),
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to login');
      }

      return AuthenticationData.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> register(
    String name,
    String surname,
    String email,
    String password,
    String documentNumber,
  ) async {
    try {
      final response = await _dio.post(
        '/register',
        data: {
          'name': name,
          'surname': surname,
          'email': email,
          'password': password,
          'documentNumber': documentNumber,
        },
      );

      if (response.statusCode != 200) {
        return false;
      }

      return true;
    } catch (e) {
      return false;
    }
  }
}
