import 'package:client/src/data/models/user.model.dart';
import 'package:client/src/data/repositories/auth.repository.dart';

abstract class AuthenticationService {
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

class AuthenticationServiceImpl implements AuthenticationService {
  final AuthenticationRepository _loginRepository;

  AuthenticationServiceImpl(this._loginRepository);

  @override
  Future<AuthenticationData?> login(
    String email,
    String password,
  ) {
    return _loginRepository.login(email, password);
  }

  @override
  Future<bool> register(
    String name,
    String surname,
    String email,
    String password,
    String documentNumber,
  ) {
    return _loginRepository.register(
      name,
      surname,
      email,
      password,
      documentNumber,
    );
  }
}
