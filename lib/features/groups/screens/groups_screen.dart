import 'package:chat_app/config/routes/app_routes.dart';
import 'package:chat_app/features/groups/screens/widgets/groups_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> groupsList = [
      {
        "name": "Diamond Team 💎",
        "msg": "Thanks a bunch! Have a great day! 😊",
        "time": "10:25",
        "count": 5,
        "image": [
          "https://upload.wikimedia.org/wikipedia/commons/thumb/2/23/Jimmy_Wales_Fundraiser_Appeal_edit.jpg/250px-Jimmy_Wales_Fundraiser_Appeal_edit.jpg",
          "https://img.freepik.com/free-photo/lifestyle-beauty-fashion-people-emotions-concept-young-asian-female-office-manager-ceo-with-pleased-expression-standing-white-background-smiling-with-arms-crossed-chest_1258-59329.jpg?semt=ais_hybrid&w=740&q=80",
        ],
        "c": 6,
      },
      {
        "name": "Group Shares Experience About AI",
        "msg": "Great, thanks so much! 💫",
        "time": "09/05",
        "count": 12,
        "image": [
          "https://upload.wikimedia.org/wikipedia/commons/thumb/2/23/Jimmy_Wales_Fundraiser_Appeal_edit.jpg/250px-Jimmy_Wales_Fundraiser_Appeal_edit.jpg",
          "https://img.freepik.com/free-photo/lifestyle-beauty-fashion-people-emotions-concept-young-asian-female-office-manager-ceo-with-pleased-expression-standing-white-background-smiling-with-arms-crossed-chest_1258-59329.jpg?semt=ais_hybrid&w=740&q=80",
        ],
        "c": 99,
      },
      {
        "name": "My charity group ❤️",
        "msg": "Appreciate it! See you soon! 🚀",
        "time": "08/05",
        "count": 1,
        "image": [
          "https://upload.wikimedia.org/wikipedia/commons/thumb/2/23/Jimmy_Wales_Fundraiser_Appeal_edit.jpg/250px-Jimmy_Wales_Fundraiser_Appeal_edit.jpg",
          "https://img.freepik.com/free-photo/lifestyle-beauty-fashion-people-emotions-concept-young-asian-female-office-manager-ceo-with-pleased-expression-standing-white-background-smiling-with-arms-crossed-chest_1258-59329.jpg?semt=ais_hybrid&w=740&q=80",
        ],
        "c": 8,
      },
      {
        "name": "🎮 Game 🎮",
        "msg": "Hooray! 🎉",
        "time": "05/05",
        "count": 0,
        "image": [
          "https://upload.wikimedia.org/wikipedia/commons/thumb/2/23/Jimmy_Wales_Fundraiser_Appeal_edit.jpg/250px-Jimmy_Wales_Fundraiser_Appeal_edit.jpg",
          "https://img.freepik.com/free-photo/lifestyle-beauty-fashion-people-emotions-concept-young-asian-female-office-manager-ceo-with-pleased-expression-standing-white-background-smiling-with-arms-crossed-chest_1258-59329.jpg?semt=ais_hybrid&w=740&q=80",
        ],
        "c": 7,
      },
      {
        "name": "Delivery",
        "msg": "Your order has been successfully delivered",
        "time": "05/05",
        "count": 0,
        "image": [
          "https://upload.wikimedia.org/wikipedia/commons/thumb/2/23/Jimmy_Wales_Fundraiser_Appeal_edit.jpg/250px-Jimmy_Wales_Fundraiser_Appeal_edit.jpg",
          "https://img.freepik.com/free-photo/lifestyle-beauty-fashion-people-emotions-concept-young-asian-female-office-manager-ceo-with-pleased-expression-standing-white-background-smiling-with-arms-crossed-chest_1258-59329.jpg?semt=ais_hybrid&w=740&q=80",
        ],
        "c": 3,
      },
      {
        "name": "Sky-diving Lion Team",
        "msg": "See you soon!",
        "time": "05/05",
        "count": 0,
        "image": [
          "https://upload.wikimedia.org/wikipedia/commons/thumb/2/23/Jimmy_Wales_Fundraiser_Appeal_edit.jpg/250px-Jimmy_Wales_Fundraiser_Appeal_edit.jpg",
          "https://img.freepik.com/free-photo/lifestyle-beauty-fashion-people-emotions-concept-young-asian-female-office-manager-ceo-with-pleased-expression-standing-white-background-smiling-with-arms-crossed-chest_1258-59329.jpg?semt=ais_hybrid&w=740&q=80",
        ],
        "c": 15,
      },
      {
        "name": "football",
        "msg": "I'm ready to drop off your delivery. 👍",
        "time": "02/05",
        "count": 0,
        "image": [
          "https://upload.wikimedia.org/wikipedia/commons/thumb/2/23/Jimmy_Wales_Fundraiser_Appeal_edit.jpg/250px-Jimmy_Wales_Fundraiser_Appeal_edit.jpg",
          "https://img.freepik.com/free-photo/lifestyle-beauty-fashion-people-emotions-concept-young-asian-female-office-manager-ceo-with-pleased-expression-standing-white-background-smiling-with-arms-crossed-chest_1258-59329.jpg?semt=ais_hybrid&w=740&q=80",
        ],
        "c": 2,
      },
      {
        "name": "IT Training",
        "msg": "Appreciate it! Hope you enjoy it!",
        "time": "01/05",
        "count": 0,
        "image": [
          "https://upload.wikimedia.org/wikipedia/commons/thumb/2/23/Jimmy_Wales_Fundraiser_Appeal_edit.jpg/250px-Jimmy_Wales_Fundraiser_Appeal_edit.jpg",
          "https://img.freepik.com/free-photo/lifestyle-beauty-fashion-people-emotions-concept-young-asian-female-office-manager-ceo-with-pleased-expression-standing-white-background-smiling-with-arms-crossed-chest_1258-59329.jpg?semt=ais_hybrid&w=740&q=80",
          "https://static.arrajol.com/styles/800x533_webp/public/2018/07/16/275121-%D8%AA%D8%B9%D8%B1%D9%81-%20%D8%B9%D9%84%D9%89-%20%D9%82%D8%B5%D8%B5-%20%D9%86%D8%AC%D8%A7%D8%AD%20%D8%A3%D8%B4%D9%87%D8%B1%20%2010%20%D8%A3%D8%B4%D8%AE%D8%A7%D8%B5%20%D9%81%D9%8A%20%D8%B9%D8%A7%D9%84%D9%85%20%D8%A7%D9%84%D9%85%D8%A7%D9%84%20%D9%88%D8%A7%D9%84%D8%A3%D8%B9%D9%85%D8%A7%D9%84_2.jpg.webp",
        ],
        "c": 3,
      },
    ];

    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push(AppRoutes.messageGroups);
      },
      child: ListView.builder(
        itemCount: groupsList.length,
        padding: const EdgeInsets.only(top: 8, bottom: 20),
        itemBuilder: (context, index) {
          final chat = groupsList[index];
          return GroupsItem(
            name: chat['name'],
            message: chat['msg'],
            time: chat['time'],
            unreadCount: chat['count'],
            image: chat['image'],
            c: chat['c'],
          );
        },
      ),
    );
  }
}
