import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/features/products/domain/repositories/product_repositories.dart';
import 'package:dartz/dartz.dart';

class FavProductUseCase {
  final ProductRepositories productRepositories;
  const FavProductUseCase({required this.productRepositories});

  Future<Either<Failure, Unit>> call(
      {required String postId,
      required String userId,
      required bool isLiked}) async {
    return await productRepositories.favProduct(postId, userId, isLiked);
  }
}
