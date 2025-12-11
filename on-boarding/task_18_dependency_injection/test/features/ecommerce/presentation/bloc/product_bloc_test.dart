import 'package:dartz/dartz.dart';
import 'package:data_overview_layer/core/error/failure.dart';
import 'package:data_overview_layer/features/ecommerce/domain/entities/product.dart';
import 'package:data_overview_layer/features/ecommerce/domain/usecase/delete_product_usecase.dart';
import 'package:data_overview_layer/features/ecommerce/domain/usecase/get_all_products_usecase.dart';
import 'package:data_overview_layer/features/ecommerce/domain/usecase/get_product_usecase.dart';
import 'package:data_overview_layer/features/ecommerce/domain/usecase/insert_product_usecase.dart';
import 'package:data_overview_layer/features/ecommerce/domain/usecase/update_product_usecase.dart';
import 'package:data_overview_layer/features/ecommerce/presentation/bloc/product_bloc.dart';
import 'package:data_overview_layer/features/ecommerce/presentation/bloc/product_event.dart';
import 'package:data_overview_layer/features/ecommerce/presentation/bloc/product_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

// import '../../domain/usecase/mock_usecase.dart';
import 'product_bloc_test.mocks.dart';

@GenerateMocks([
  GetAllProducts,
  GetProduct,
  InsertProduct,
  UpdateProduct,
  DeleteProduct,
])
void main() {
  late ProductBloc bloc;
  late MockGetAllProducts mockGetAllProducts;
  late MockGetProduct mockGetProduct;
  late MockUpdateProduct mockUpdateProduct;
  late MockDeleteProduct mockDeleteProduct;
  late MockInsertProduct mockInsertProduct;

  final tProduct = Product(
    id: '1',
    name: 'Test',
    description: 'Test description',
    imageUrl: 'image/ur.png',
    price: 232.2,
  );
  final testProducts = [tProduct];

  setUp(() {
    mockGetAllProducts = MockGetAllProducts();
    mockGetProduct = MockGetProduct();
    mockUpdateProduct = MockUpdateProduct();
    mockDeleteProduct = MockDeleteProduct();
    mockInsertProduct = MockInsertProduct();

    bloc = ProductBloc(
      getAllProducts: mockGetAllProducts,
      getSingleProduct: mockGetProduct,
      updateProduct: mockUpdateProduct,
      deleteProduct: mockDeleteProduct,
      createProduct: mockInsertProduct,
    );
  });

  test('Intial state should be IntialState', () {
    expect(bloc.state, equals(IntialState()));
  });

  test('emits [LoadingState, LoadedAllProductState] on success', () async {
    when(mockGetAllProducts()).thenAnswer((_) async => Right(testProducts));

    final expected = [LoadingState(), LoadedAllProductState(testProducts)];

    expectLater(bloc.stream, emitsInOrder(expected));

    bloc.add(LoadAllProductEvent());
  });

  test('emits [LoadingState, ErrorState] on failure', () async {
    when(
      mockGetAllProducts(),
    ).thenAnswer((_) async => Left(ServerFailure(message: 'Error')));

    final expected = [LoadingState(), ErrorState('Error')];

    expectLater(bloc.stream, emitsInOrder(expected));

    bloc.add(LoadAllProductEvent());
  });

  test('emits [LoadingState, LoadedSingleProductState] on success', () async {
    when(mockGetProduct(any)).thenAnswer((_) async => Right(tProduct));

    final expected = [LoadingState(), LoadedSingleProductState(tProduct)];

    expectLater(bloc.stream, emitsInOrder(expected));

    bloc.add(GetSingleProductEvent('1'));
  });

  test(
    'emits [LoadingState, LoadedAllProductState] on successful insert',
    () async {
      when(mockInsertProduct.call(any)).thenAnswer((_) async => Right(unit));
      when(
        mockGetAllProducts.call(),
      ).thenAnswer((_) async => Right(testProducts));

      final expected = [LoadingState(), LoadedAllProductState(testProducts)];

      final future = expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(CreateProductEvent(tProduct));
      await future;

      verify(mockInsertProduct.call(tProduct)).called(1);
      verify(mockGetAllProducts.call()).called(1);
    },
  );

  test('emits [LoadingState, ErrorState] on failure', () async {
    when(
      mockInsertProduct(any),
    ).thenAnswer((_) async => Left(ServerFailure(message: 'Error')));

    final expected = [LoadingState(), ErrorState('Error')];

    expectLater(bloc.stream, emitsInOrder(expected));

    bloc.add(CreateProductEvent(tProduct));
  });

  test(
    'emits [LoadingState, LoadedAllProductState] on successful update',
    () async {
      when(mockUpdateProduct.call(any)).thenAnswer((_) async => Right(unit));
      when(
        mockGetAllProducts.call(),
      ).thenAnswer((_) async => Right(testProducts));

      final expected = [LoadingState(), LoadedAllProductState(testProducts)];

      final future = expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(UpdateProductEvent(tProduct));

      await future;

      verify(mockUpdateProduct.call(tProduct)).called(1);
      verify(mockGetAllProducts.call()).called(1);
    },
  );

  test('emits [LoadingState, ErrorState] on failure', () async {
    when(
      mockUpdateProduct(any),
    ).thenAnswer((_) async => Left(ServerFailure(message: 'Error')));

    final expected = [LoadingState(), ErrorState('Error')];

    expectLater(bloc.stream, emitsInOrder(expected));

    bloc.add(UpdateProductEvent(tProduct));
  });

  test(
    'emits [LoadingState, LoadedAllProductState] on successful delete',
    () async {
      when(mockDeleteProduct.call(any)).thenAnswer((_) async => Right(unit));
      when(
        mockGetAllProducts.call(),
      ).thenAnswer((_) async => Right(testProducts));

      final expected = [LoadingState(), LoadedAllProductState(testProducts)];

      final future = expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(DeleteProductEvent('1'));

      await future;

      verify(mockDeleteProduct.call('1')).called(1);
      verify(mockGetAllProducts.call()).called(1);
    },
  );

  test('emits [LoadingState, ErrorState] on failure', () async {
    when(
      mockDeleteProduct(any),
    ).thenAnswer((_) async => Left(ServerFailure(message: 'Error')));

    final expected = [LoadingState(), ErrorState('Error')];

    expectLater(bloc.stream, emitsInOrder(expected));

    bloc.add(DeleteProductEvent('1'));
  });
}
