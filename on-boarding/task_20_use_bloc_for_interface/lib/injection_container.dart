import 'package:data_overview_layer/core/network/api_client.dart';
import 'package:data_overview_layer/core/network/network_info.dart';
import 'package:data_overview_layer/features/ecommerce/data/data_source/product_local_data_source.dart';
import 'package:data_overview_layer/features/ecommerce/data/data_source/product_remote_data_source.dart';
import 'package:data_overview_layer/features/ecommerce/data/repositories/product_repository_impl.dart';
import 'package:data_overview_layer/features/ecommerce/domain/repository/product_repository.dart';
import 'package:data_overview_layer/features/ecommerce/domain/usecase/delete_product_usecase.dart';
import 'package:data_overview_layer/features/ecommerce/domain/usecase/get_all_products_usecase.dart';
import 'package:data_overview_layer/features/ecommerce/domain/usecase/get_product_usecase.dart';
import 'package:data_overview_layer/features/ecommerce/domain/usecase/insert_product_usecase.dart';
import 'package:data_overview_layer/features/ecommerce/domain/usecase/update_product_usecase.dart';
import 'package:data_overview_layer/features/ecommerce/presentation/bloc/product_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features of ecommerce

  // Bloc
  sl.registerFactory(
    () => ProductBloc(
      getAllProducts: sl(),
      getSingleProduct: sl(),
      updateProduct: sl(),
      deleteProduct: sl(),
      createProduct: sl(),
    ),
  );

  // usecases
  sl.registerLazySingleton(() => GetAllProducts(sl()));
  sl.registerLazySingleton(() => GetProduct(sl()));
  sl.registerLazySingleton(() => InsertProduct(sl()));
  sl.registerLazySingleton(() => UpdateProduct(sl()));
  sl.registerLazySingleton(() => DeleteProduct(sl()));

  // repository
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // data sources
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<ProductLocalDataSource>(
    () => ProductLocalDataSourceImpl(sharedPreferences: sl()),
  );

  //! Core
  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl<InternetConnectionChecker>()),
  );
  sl.registerLazySingleton<ApiClient>(
    () => ApiClient(
      client: sl(),
      baseUrl: "https://g5-flutter-learning-path-be.onrender.com/api/v1/",
    ),
  );

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
}
