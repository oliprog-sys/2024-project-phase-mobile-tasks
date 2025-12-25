import 'package:authentication_feature/core/network/api_client.dart';
import 'package:authentication_feature/features/auth/data/dataSources/auth_local_data_source.dart';
import 'package:authentication_feature/features/auth/data/dataSources/auth_remote_data_source.dart';
import 'package:authentication_feature/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:authentication_feature/features/auth/domain/repositories/auth_repository.dart';
import 'package:authentication_feature/features/auth/domain/usecases/get_saved_token_usecase.dart';
import 'package:authentication_feature/features/auth/domain/usecases/log_out_usecase.dart';
import 'package:authentication_feature/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:authentication_feature/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:authentication_feature/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  //! Features of eccomerce

  // Bloc
  sl.registerFactory(
    () => AuthBloc(
      signInUseCase: sl(),
      signUpUseCase: sl(),
      logOutUseCase: sl(),
      getSavedTokenUsecase: sl(),
    ),
  );

  // usecases
  sl.registerLazySingleton(() => SignInUsecase(sl()));
  sl.registerLazySingleton(() => SignUpUsecase(sl()));
  sl.registerLazySingleton(() => LogOutUsecase(sl()));
  sl.registerLazySingleton(() => GetSavedTokenUsecase(sl()));

  // repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl()),
  );

  // Data source
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => MockAuthRemoteDataSource(),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sl()),
  );

  sl.registerLazySingleton(() => ApiClient(client: http.Client(), baseUrl: ''));
  sl.registerLazySingleton(() => const FlutterSecureStorage());
}
