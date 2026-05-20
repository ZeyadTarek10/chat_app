import 'package:chat_app/config/app/upload_image/data/data_source/upload_image_remote_data_source.dart';
import 'package:chat_app/config/app/upload_image/domain/entities/upload_image_entities.dart';
import 'package:chat_app/config/app/upload_image/domain/repositories/upload_image_repositories.dart';
import 'package:chat_app/core/error/failures.dart';
import 'package:chat_app/core/network/netwok_info.dart';
import 'package:dartz/dartz.dart';

class UploadImageRepositoriesImpl implements UploadImageRepositories {
  final NetworkInfo networkInfo;
  final UploadImageRemoteDataSource uploadImageDataSource;

  UploadImageRepositoriesImpl(
      {required this.networkInfo, required this.uploadImageDataSource});

  @override
  Future<Either<Failure, UploadImageEntities>> postImage() async {
    try {
      final response = await uploadImageDataSource.postImage();
      return Right(response);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }
}


// class UploadImageRepo {
//   const UploadImageRepo(this._dataSource);

//   final UploadImageDataSource _dataSource;

//   Future<ApiResult<UploadImageResourse>> uploadImage(XFile imageFile) async {
//     try {
//       final response = await _dataSource.uploadImage(imageFile: imageFile);

//       return ApiResult.success(response);
//     } catch (e) {
//       return const ApiResult.failure('Please, try agian we have error');
//     }
//   }
// }
