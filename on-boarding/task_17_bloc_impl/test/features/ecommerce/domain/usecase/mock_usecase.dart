import 'package:mockito/mockito.dart';
import 'package:data_overview_layer/features/ecommerce/domain/usecase/delete_product_usecase.dart';
import 'package:data_overview_layer/features/ecommerce/domain/usecase/get_all_products_usecase.dart';
import 'package:data_overview_layer/features/ecommerce/domain/usecase/get_product_usecase.dart';
import 'package:data_overview_layer/features/ecommerce/domain/usecase/insert_product_usecase.dart';
import 'package:data_overview_layer/features/ecommerce/domain/usecase/update_product_usecase.dart';

class MockGetAllProducts extends Mock implements GetAllProducts {}
class MockGetProduct extends Mock implements GetProduct {}
class MockUpdateProduct extends Mock implements UpdateProduct {}
class MockDeleteProduct extends Mock implements DeleteProduct {}
class MockInsertProduct extends Mock implements InsertProduct {}
  