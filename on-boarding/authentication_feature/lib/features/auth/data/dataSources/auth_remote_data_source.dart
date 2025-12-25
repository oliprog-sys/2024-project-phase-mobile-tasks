// import 'package:authentication_feature/core/network/api_client.dart';
import 'package:authentication_feature/features/auth/data/model/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signIn(String email, String password);
  Future<UserModel> signUp(String name, String email, String password);
}

class MockAuthRemoteDataSource implements AuthRemoteDataSource {
  UserModel? mockUser;

  @override
  Future<UserModel> signUp(String name, String email, String password) async {
    final user = UserModel(
      id: '1',
      name: name,
      email: email,
      token: "mock token",
    );

    mockUser = user;
    return user;
  }

  @override
  Future<UserModel> signIn(String email, String password) async {
    if (mockUser == null) {
      throw Exception('No mock user available');
    }

    if (mockUser!.email != email || password != '11223344') {
      throw Exception("Invalid credentials");
    }
    return mockUser!;
  }
}
