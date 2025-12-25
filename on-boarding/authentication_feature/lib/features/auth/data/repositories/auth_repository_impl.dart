
import 'package:authentication_feature/features/auth/data/dataSources/auth_local_data_source.dart';
import 'package:authentication_feature/features/auth/data/dataSources/auth_remote_data_source.dart';
import 'package:authentication_feature/features/auth/domain/entity/user.dart';
import 'package:authentication_feature/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository{
  final AuthRemoteDataSource remote;
  final AuthLocalDataSource local;

  AuthRepositoryImpl(this.remote, this.local);

  @override
  Future<String?> getToken() {
    return local.getToken();
  }

  @override
  Future<void> logOut() {
    return local.clearToken();
  }

  @override
  Future<void> saveToken(String token) {
    return local.saveToken(token);
  }

  @override
  Future<User> signIn(String email, String password) async {
    final user = await remote.signIn(email, password);
    await local.saveToken(user.token);
    return user;
  }

  @override
  Future<User> signUp(String name, String email, String password) async {
    final user = await remote.signUp(name, email, password);
    await local.saveToken(user.token);
    return user;
  }

  
}