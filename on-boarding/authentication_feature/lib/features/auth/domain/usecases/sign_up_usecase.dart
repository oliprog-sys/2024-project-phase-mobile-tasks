import 'package:authentication_feature/features/auth/domain/entity/user.dart';
import 'package:authentication_feature/features/auth/domain/repositories/auth_repository.dart';

class SignUpUsecase {
  final AuthRepository authRepository;

  SignUpUsecase(this.authRepository);

  Future<User> call(String name, String email, String password) {
    return authRepository.signUp(name, email, password);
  }
}