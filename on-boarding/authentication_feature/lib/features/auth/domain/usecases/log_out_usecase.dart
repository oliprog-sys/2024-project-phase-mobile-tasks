
import 'package:authentication_feature/features/auth/domain/repositories/auth_repository.dart';

class LogOutUsecase {
  final AuthRepository authRepository;

  LogOutUsecase(this.authRepository);

  Future<void> call() {
    return authRepository.logOut();
  }
}