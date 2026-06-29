import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/products/domain/entities/product_entity.dart';
import 'package:chat_app/features/products/domain/repositories/product_repositories.dart';
import 'package:dartz/dartz.dart';

class AddProductUseCase {
  final ProductRepositories productRepositories;
  const AddProductUseCase({required this.productRepositories});

  Future<Either<Failure, Unit>> call({required ProductEntity product}) async {
    return await productRepositories.addProduct(product);
  }
}