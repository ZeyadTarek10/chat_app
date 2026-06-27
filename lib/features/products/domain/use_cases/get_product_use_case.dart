import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/products/domain/entities/product_entity.dart';
import 'package:chat_app/features/products/domain/repositories/product_repositories.dart';
import 'package:dartz/dartz.dart';

class GetProductUseCase {
  final ProductRepositories productRepositories;
  GetProductUseCase({required this.productRepositories});

  Stream<Either<Failure, List<ProductEntity>>> call() {
    return productRepositories.getProduct();
  }
}