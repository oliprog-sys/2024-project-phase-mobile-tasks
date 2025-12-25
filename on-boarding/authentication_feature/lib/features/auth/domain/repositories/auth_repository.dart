
import 'package:authentication_feature/features/auth/domain/entity/user.dart';

abstract class AuthRepository {
  Future<User> signIn(String email, String password);
  Future<User> signUp(String email, String password, String name);
  Future<void> logOut();
  Future<void> saveToken(String token);
  Future<String?> getToken();
}