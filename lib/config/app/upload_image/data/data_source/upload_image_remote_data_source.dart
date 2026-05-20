import 'package:chat_app/config/app/upload_image/data/model/upload_image_response.dart';
import 'package:chat_app/core/api/api_consumer.dart';
import 'package:chat_app/core/api/end_points.dart';


abstract class UploadImageRemoteDataSource {
  Future<UploadImageModel> postImage();
}

class UploadImageRemoteDataSourceImpl implements UploadImageRemoteDataSource {
  final ApiConsumer image;
  final endPoints = 'photo';

  UploadImageRemoteDataSourceImpl({required this.image});

  @override
  Future<UploadImageModel> postImage() async {
    var res = await image.post(EndPoints.baseUrl);
    return UploadImageModel.fromJson(res);
  }
}