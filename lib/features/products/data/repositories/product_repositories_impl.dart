import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/core/network/netwok_info.dart';
import 'package:chat_app/features/products/data/data_source/product_remote_data_source.dart';
import 'package:chat_app/features/products/data/models/product_model.dart';
import 'package:chat_app/features/products/domain/entities/product_entity.dart';
import 'package:chat_app/features/products/domain/repositories/product_repositories.dart';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';

class ProductRepositoriesImpl implements ProductRepositories {
  final NetworkInfo networkInfo;
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoriesImpl(
      {required this.networkInfo, required this.remoteDataSource});

  @override
  Stream<Either<Failure, List<ProductEntity>>> getProduct() async* {
    if (await networkInfo.isConnected) {
      try {
        yield* remoteDataSource
            .getProduct()
            .map<Either<Failure, List<ProductEntity>>>(
              (posts) => Right(posts),
            );
      } catch (error) {
        yield Left(ServerFailure(error.toString()));
      }
    } else {
      yield Left(CacheFailure("no_internet_connection".tr()));
    }
  }

  @override
  Future<Either<Failure, Unit>> addProduct(ProductEntity product) async {
    if (await networkInfo.isConnected) {
      try {
        final productModel = ProductModel(
          id: product.id,
          userId: product.userId,
          productImage: product.productImage,
          productGallaryImage: product.productGallaryImage,
          productTitle: product.productTitle,
          type: product.type,
          price: product.price,
          discription: product.discription,
          time: product.time,
          favCount: product.favCount,
          favBy: product.favBy,
          isAvailable: product.isAvailable
        );
        await remoteDataSource.addProduct(productModel);
        return const Right(unit);
      } catch (error) {
        return Left(ServerFailure(error.toString()));
      }
    } else {
      return Left(CacheFailure("no_internet_connection".tr()));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateProduct(ProductEntity product) async {
    if (await networkInfo.isConnected) {
      try {
        final productModel = ProductModel(
          id: product.id,
          userId: product.userId,
          productImage: product.productImage,
          productGallaryImage: product.productGallaryImage,
          productTitle: product.productTitle,
          type: product.type,
          price: product.price,
          discription: product.discription,
          time: product.time,
          favCount: product.favCount,
          favBy: product.favBy,
          isAvailable: product.isAvailable
        );
        await remoteDataSource.updateProduct(productModel);
        return const Right(unit);
      } catch (error) {
        return Left(ServerFailure(error.toString()));
      }
    } else {
      return Left(CacheFailure("no_internet_connection".tr()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteProduct(String postId) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteProduct(postId);
        return const Right(unit);
      } catch (error) {
        return Left(ServerFailure(error.toString()));
      }
    } else {
      return Left(CacheFailure("no_internet_connection".tr()));
    }
  }

  @override
  Future<Either<Failure, Unit>> favProduct(
      String postId, String userId, bool isLiked) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.favProduct(postId, userId, isLiked);
        return const Right(unit);
      } catch (error) {
        return Left(ServerFailure(error.toString()));
      }
    } else {
      return Left(CacheFailure("no_internet_connection".tr()));
    }
  }
}
