import 'package:data_overview_layer/features/ecommerce/domain/entities/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:data_overview_layer/features/ecommerce/domain/usecase/delete_product_usecase.dart';
import 'package:data_overview_layer/features/ecommerce/domain/usecase/get_all_products_usecase.dart';
import 'package:data_overview_layer/features/ecommerce/domain/usecase/get_product_usecase.dart';
import 'package:data_overview_layer/features/ecommerce/domain/usecase/insert_product_usecase.dart';
import 'package:data_overview_layer/features/ecommerce/domain/usecase/update_product_usecase.dart';
import 'package:data_overview_layer/features/ecommerce/presentation/bloc/product_event.dart';
import 'package:data_overview_layer/features/ecommerce/presentation/bloc/product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetAllProducts getAllProducts;
  final GetProduct getSingleProduct;
  final UpdateProduct updateProduct;
  final DeleteProduct deleteProduct;
  final InsertProduct createProduct;

  ProductBloc({
    required this.getAllProducts,
    required this.getSingleProduct,
    required this.updateProduct,
    required this.deleteProduct,
    required this.createProduct,
  }) : super(IntialState()) {
    on<LoadAllProductEvent>(loadAllProducts);
    on<GetSingleProductEvent>(getProduct);
    on<CreateProductEvent>(insertProduct);
    on<UpdateProductEvent>(updateProductFunc);
    on<DeleteProductEvent>(deleteProductFunc);
  }

  Future<void> loadAllProducts(
    LoadAllProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(LoadingState());
    final result = await getAllProducts();
    result.fold(
      (failure) => emit(ErrorState(failure.message)),
      (products) => emit(LoadedAllProductState(products)),
    );
  }

  Future<void> getProduct(
    GetSingleProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(LoadingState());
    final result = await getSingleProduct(event.id);
    result.fold(
      (failure) => emit(ErrorState(failure.message)),
      (product) => emit(LoadedSingleProductState(product)),
    );
  }

  Future<void> insertProduct(
    CreateProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    final currentState = state;

    if (currentState is LoadedAllProductState) {
      final updatedProducts = List<Product>.from(currentState.products)
        ..add(event.product);

      emit(LoadedAllProductState(updatedProducts));
    } else {
      emit(LoadedAllProductState([event.product]));
    }

    final result = await createProduct(event.product);
    result.fold((failure) => emit(ErrorState(failure.message)), (_) {});
  }

  Future<void> updateProductFunc(
    UpdateProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(LoadingState());

    final result = await updateProduct(event.product);

    if (result.isLeft()) {
      emit(
        ErrorState(result.swap().getOrElse(() => throw Exception()).message),
      );
      return;
    }

    final allProductsResult = await getAllProducts();

    allProductsResult.fold(
      (failure) => emit(ErrorState(failure.message)),
      (products) => emit(LoadedAllProductState(products)),
    );
  }

  Future<void> deleteProductFunc(
    DeleteProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(LoadingState());

    final result = await deleteProduct(event.id);

    if (result.isLeft()) {
      emit(
        ErrorState(result.swap().getOrElse(() => throw Exception()).message),
      );
      return;
    }

    final allProductsResult = await getAllProducts();

    allProductsResult.fold(
      (failure) => emit(ErrorState(failure.message)),
      (products) => emit(LoadedAllProductState(products)),
    );
  }
}
