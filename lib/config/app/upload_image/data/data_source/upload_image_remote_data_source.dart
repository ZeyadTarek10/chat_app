import 'package:chat_app/config/app/upload_image/data/model/upload_image_response.dart';
import 'package:chat_app/core/api/api_consumer.dart';
import 'package:chat_app/core/api/end_points.dart';
import 'package:dio/dio.dart';
import 'package:share_plus/share_plus.dart';

abstract class UploadImageRemoteDataSource {
  Future<UploadImageModel> postImage(XFile imageXFile);
}

class UploadImageRemoteDataSourceImpl implements UploadImageRemoteDataSource {
  final ApiConsumer image;
  UploadImageRemoteDataSourceImpl({required this.image});

  @override
  Future<UploadImageModel> postImage(XFile imageXFile) async {
    final Map<String, dynamic> fromDataMap = {
      'photo': await MultipartFile.fromFile(imageXFile.path,
          filename: imageXFile.name),
    };
    var res = await image.post(
      EndPoints.baseUrl,
      body: fromDataMap,
      formDataIsEnabled: true
      );
    return UploadImageModel.fromJson(res);
  }
}
