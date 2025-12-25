
import 'package:authentication_feature/features/auth/domain/repositories/auth_repository.dart';

class GetSavedTokenUsecase {
  final AuthRepository authRepository;

  GetSavedTokenUsecase(this.authRepository);

  Future<String?> call() {
    return authRepository.getToken();
  }
}