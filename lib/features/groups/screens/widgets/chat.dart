import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';

class Chat extends StatelessWidget {
  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    return  ListTile(
      leading: const CircleAvatar(child: Text("E"),),
      minLeadingWidth: 20,
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomTextWidget(text: "Erin Turcotte"),
          CustomTextWidget(text: "19:35 02/05")
        ],
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const CustomTextWidget(text: "I'm ready to drop off your delivery. 👍"),
           Padding(
             padding: const EdgeInsets.all(8),
             child: Container(
                       width: 20,
                       decoration: BoxDecoration(
              color: AppColors.backgroundColorbuttonblue1,
              borderRadius: BorderRadius.circular(4)
                       ),
                       child: const Center(child: Text('22', style: TextStyle(color: Colors.white),)),
                     ),
           ),
        ],
      ),
    );
  }
}