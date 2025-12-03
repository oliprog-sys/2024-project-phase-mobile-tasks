import 'package:mockito/annotations.dart';
import 'package:data_overview_layer/features/ecommerce/data/data_source/product_remote_data_source.dart';
import 'package:data_overview_layer/features/ecommerce/data/data_source/product_local_data_source.dart';
import 'package:data_overview_layer/core/platform/network_info.dart';

@GenerateMocks([
  ProductRemoteDataSource,
  ProductLocalDataSource,
  NetworkInfo
])
void main() {}