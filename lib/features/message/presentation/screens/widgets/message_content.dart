import 'dart:convert';
import 'package:chat_app/core/services/url_launcher_service.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageContent extends StatelessWidget {
  final String type;
  final String message;
  final bool isMe;

  const MessageContent({
    super.key,
    required this.type,
    required this.message,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    if (type == "image") {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: CachedNetworkImage(
          imageUrl: message,
          placeholder: (context, url) => SizedBox(
            width: 150.w,
            height: 150.h,
            child: const Center(
              child: CircularProgressIndicator(color: ColorsDark.blueLight1),
            ),
          ),
          errorWidget: (context, url, error) => const Icon(
            Icons.image_not_supported_outlined,
            size: 50,
            color: ColorsLight.mainTextColor,
          ),
          width: 200.w,
          fit: BoxFit.cover,
        ),
      );
    } else if (type == "location") {
      Map<String, dynamic> locData = {};
      try {
        locData = jsonDecode(message);
      } catch (e) {
        locData = {'lat': '0', 'lng': '0', 'address': "unknown_location".tr()};
      }

      final String lat = locData['lat'] ?? '0';
      final String lng = locData['lng'] ?? '0';
      final String address = locData['address'] ?? "unknown_location".tr();

      return GestureDetector(
        onTap: () => UrlLauncherService().openMap(lat, lng),
        child: Container(
          width: 220.w,
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            color: isMe
                ? ColorsDark.white.withOpacity(0.15)
                : Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              const CircleAvatar(
                backgroundColor: Colors.redAccent,
                child: Icon(Icons.location_on, color: ColorsDark.white),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextWidget(
                      text: "live_location".tr(),
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: FontDetails.fontSizeS,
                        color: isMe ? ColorsLight.white : ColorsLight.black,
                      ),
                    ),
                    CustomTextWidget(
                      text: address,
                      maxLines: 2,
                      textStyle: TextStyle(
                        fontSize: FontDetails.fontSizeXS,
                        color: isMe ? Colors.white70 : Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else if (type == "contact") {
      Map<String, dynamic> contactData = {};
      try {
        contactData = jsonDecode(message);
      } catch (e) {
        contactData = {"name": "unknown".tr(), "phone": ""};
      }
      return Container(
        width: 230.w,
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: isMe ? ColorsDark.white.withOpacity(0.15) : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: isMe ? ColorsDark.white : ColorsDark.blueLight1,
              child: Icon(
                Icons.person,
                color: isMe ? ColorsDark.bublechat : ColorsDark.white,
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextWidget(
                    text: contactData['name'] ?? "",
                    textStyle: TextStyle(
                      color: isMe ? ColorsLight.white : ColorsLight.black,
                      fontWeight: FontWeight.bold,
                      fontSize: FontDetails.fontSizeS,
                    ),
                  ),
                  CustomTextWidget(
                    text: contactData['phone'] ?? "",
                    textStyle: TextStyle(
                      color: isMe ? Colors.white70 : Colors.black54,
                      fontSize: FontDetails.fontSizeXS,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
                icon: Icon(
                  Icons.call,
                  color: isMe ? ColorsLight.white : ColorsDark.blueLight1,
                ),
                onPressed: () =>
                    UrlLauncherService().callPhone(contactData['phone'] ?? ""))
          ],
        ),
      );
    } else {
      return CustomTextWidget(
        text: message,
        textStyle: TextStyle(
          color: isMe ? ColorsLight.white : ColorsLight.black,
          fontSize: FontDetails.fontSizeS,
        ),
      );
    }
  }
}
