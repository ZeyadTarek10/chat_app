import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';

class ChatsItem extends StatelessWidget {

  final String name;
  final  String message;
  final String time;
  final int unreadCount;
  final String? image;

  const ChatsItem({
    super.key,
    required this.name,
    required this.message,
    required this.time,
    this.unreadCount = 0, this.image,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: CircleAvatar(
        radius: 26,
        backgroundColor: Colors.grey.shade300,
        backgroundImage: (image != null && image!.isNotEmpty) ? NetworkImage(image!) : null,
        child: (image == null || image!.isEmpty)
            ? CustomTextWidget(
               text: name.isNotEmpty ? name[0].toUpperCase() : '',
                textStyle: TextStyle(color: AppColors.black, fontSize: 20),
              )
            : null,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: CustomTextWidget(
              text:  name,
              textStyle: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: AppColors.black,
              ),
              maxLines: 1,
            ),
          ),
          const SizedBox(width: 8),
          CustomTextWidget(
           text:  time,
            textStyle: TextStyle(
              color: AppColors.mainTextColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CustomTextWidget(
                text:  message,
                textStyle: TextStyle(
                  color: AppColors.mainTextColor,
                  fontSize: 13,
                  fontWeight: unreadCount > 0 ? FontWeight.w500 : FontWeight.normal,
                ),
                maxLines: 1,
              ),
            ),
            const SizedBox(width: 8),
            if (unreadCount > 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.backgroundColorbuttonblue2, 
                  borderRadius: BorderRadius.circular(6),
                ),
                child: CustomTextWidget(
                  text: unreadCount.toString(),
                  textStyle: TextStyle(
                    color: AppColors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}