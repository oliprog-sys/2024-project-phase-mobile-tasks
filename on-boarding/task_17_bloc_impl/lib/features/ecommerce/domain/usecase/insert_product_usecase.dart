
import 'package:dartz/dartz.dart';
import 'package:data_overview_layer/core/error/exception.dart';
import 'package:data_overview_layer/core/error/failure.dart';
import 'package:data_overview_layer/features/ecommerce/domain/entities/product.dart';
import 'package:data_overview_layer/features/ecommerce/domain/repository/product_repository.dart';

class InsertProduct {
  final ProductRepository repository;

  InsertProduct(this.repository);

  Future<Either<Failure,Unit>> call(Product product) async {
    try {
      await repository.insertProduct(product);  
      return Right(unit);                       
    } on ServerException {
      return Left(ServerFailure());             
    } on CacheException {
      return Left(CacheFailure());              
    } catch (e) {
      return Left(ServerFailure());             
    }
  }
}