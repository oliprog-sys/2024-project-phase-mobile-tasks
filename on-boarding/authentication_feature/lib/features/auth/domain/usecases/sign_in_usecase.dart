
import 'package:authentication_feature/features/auth/domain/entity/user.dart';
import 'package:authentication_feature/features/auth/domain/repositories/auth_repository.dart';

class SignInUsecase {
  final AuthRepository authRepository;

  SignInUsecase(this.authRepository);

  Future<User> call(String email, String password) async {
    final user = await authRepository.signIn(email, password);
    await authRepository.saveToken(user.token);
    return user;
  }
}