import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/products/domain/repositories/product_repositories.dart';
import 'package:dartz/dartz.dart';

class DeleteProductUseCase {
  final ProductRepositories productRepositories;
  const DeleteProductUseCase({required this.productRepositories});

  Future<Either<Failure, Unit>> call({required String postId}) async {
    return await productRepositories.deleteProduct(postId);
  }
}