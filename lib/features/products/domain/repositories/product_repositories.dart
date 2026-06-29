import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/products/domain/entities/product_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ProductRepositories {
  Stream<Either<Failure, List<ProductEntity>>> getProduct();
  Future<Either<Failure, Unit>> addProduct(ProductEntity product);
  Future<Either<Failure, Unit>> updateProduct(ProductEntity product);
  Future<Either<Failure, Unit>> deleteProduct(String productId);
  Future<Either<Failure, Unit>> favProduct(String productId, String userId, bool isLiked);
}
