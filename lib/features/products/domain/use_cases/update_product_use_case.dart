import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/products/domain/entities/product_entity.dart';
import 'package:chat_app/features/products/domain/repositories/product_repositories.dart';
import 'package:dartz/dartz.dart';

class UpdateProductUseCase {
  final ProductRepositories productRepositories;
  const UpdateProductUseCase({required this.productRepositories});

  Future<Either<Failure, Unit>> call(ProductEntity product) async {
    return await productRepositories.updateProduct(product);
  }
}