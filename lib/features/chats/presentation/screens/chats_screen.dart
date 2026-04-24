import 'package:chat_app/features/chats/presentation/screens/widgets/chat_item.dart';
import 'package:flutter/material.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> chatList = [
      {
        "name": "David Wayne",
        "msg": "Thanks a bunch! Have a great day! 😄",
        "time": "10:25",
        "count": 5,
         "image" : "https://upload.wikimedia.org/wikipedia/commons/thumb/2/23/Jimmy_Wales_Fundraiser_Appeal_edit.jpg/250px-Jimmy_Wales_Fundraiser_Appeal_edit.jpg",
      },
      {
        "name": "Edward Davidson",
        "msg": "Great, thanks so much! 💫",
        "time": "22:20 09/05",
        "count": 12,
      },
      {
        "name": "Angela Kelly",
        "msg": "Appreciate it! See you soon! 🚀",
        "time": "10:45 08/05",
        "count": 1,
        "image": "https://img.freepik.com/free-photo/lifestyle-beauty-fashion-people-emotions-concept-young-asian-female-office-manager-ceo-with-pleased-expression-standing-white-background-smiling-with-arms-crossed-chest_1258-59329.jpg?semt=ais_hybrid&w=740&q=80",
      },
      {
        "name": "Jean Dare",
        "msg": "Hooray! 🎉",
        "time": "20:10 05/05",
        "count": 0,
        "image": "https://static.arrajol.com/styles/800x533_webp/public/2018/07/16/275121-%D8%AA%D8%B9%D8%B1%D9%81-%20%D8%B9%D9%84%D9%89-%20%D9%82%D8%B5%D8%B5-%20%D9%86%D8%AC%D8%A7%D8%AD%20%D8%A3%D8%B4%D9%87%D8%B1%20%2010%20%D8%A3%D8%B4%D8%AE%D8%A7%D8%B5%20%D9%81%D9%8A%20%D8%B9%D8%A7%D9%84%D9%85%20%D8%A7%D9%84%D9%85%D8%A7%D9%84%20%D9%88%D8%A7%D9%84%D8%A3%D8%B9%D9%85%D8%A7%D9%84_2.jpg.webp",
      },
      {
        "name": "Dennis Borer",
        "msg": "Your order has been successfully delivered",
        "time": "17:02 05/05",
        "count": 0
      },
      {
        "name": "Cayla Rath",
        "msg": "See you soon!",
        "time": "11:20 05/05",
        "count": 0
      },
      {
        "name": "Erin Turcotte",
        "msg": "I'm ready to drop off your delivery. 👍",
        "time": "19:35 02/05",
        "count": 0
      },
    ];

    return ListView.builder(
      itemCount: chatList.length,
      padding: const EdgeInsets.only(top: 8, bottom: 20),
      itemBuilder: (context, index) {
        final chat = chatList[index];
        return ChatsItem(
          name: chat['name'],
          message: chat['msg'],
          time: chat['time'],
          unreadCount: chat['count'],
          image: chat['image'],
        );
      },
    );
  }
}
