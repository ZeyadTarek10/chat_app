import 'package:chat_app/core/api/api_consumer.dart';
import 'package:chat_app/features/chats/data/models/chats_model.dart';

abstract class ChatsRemoteDataSource {
  Future<ChatsModel> getChats();
}

class ChatsRemoteDataSourceImpl implements ChatsRemoteDataSource {
  final ApiConsumer client;

  ChatsRemoteDataSourceImpl({required this.client});

  @override
  Future<ChatsModel> getChats() async {
    var res = await client.get('EndPoints.getCatFact');
    return ChatsModel.fromJson(res);
  }
}
