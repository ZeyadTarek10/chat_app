import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/config/routes/app_routes.dart';
import 'package:chat_app/core/enum/alert_enum.dart';
import 'package:chat_app/core/services/alert_service.dart';
import 'package:chat_app/core/services/url_launcher_service.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/features/products/data/models/product_model.dart';
import 'package:chat_app/features/products/presentation/manager/add_cubit/product_cubit.dart';
import 'package:chat_app/features/social/data/models/social_model.dart';
import 'package:chat_app/features/social/domain/entities/social_entity.dart';
import 'package:chat_app/features/social/presentation/manager/social_cubit/social_cubit.dart';
import 'package:chat_app/features/social/presentation/manager/story_cubit/story_cubit.dart';
import 'package:chat_app/injection_container.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart'
    show StringTranslateExtension;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

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
          color:
              isMe ? ColorsDark.white.withOpacity(0.15) : Colors.grey.shade100,
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
    } else if (type == "post_share") {
      Map<String, dynamic> postData = {};
      try {
        postData = jsonDecode(message);
      } catch (e) {
        postData = {
          "userName": "unknown".tr(),
          "postText": "invalid_shared_post_data".tr()
        };
      }
      final String userName =
          postData['userName'] ?? postData['user_name'] ?? "User";
      final String postText =
          postData['postText'] ?? postData['post_text'] ?? "";
      final String postImage =
          postData['postImage'] ?? postData['post_image'] ?? "";
      return GestureDetector(
        onTap: () async {
          SocialEntity? post;
          try {
            post = SocialModel.fromJson(postData);
          } catch (e) {
            post = null;
          }
          try {
            final postDoc = await FirebaseFirestore.instance
                .collection('posts')
                .doc(post!.id)
                .get();

            if (!postDoc.exists) {
              AlertService().showAlert(
                  context: context,
                  subtitle: "this_post_has_been_deleted".tr(),
                  status: AlertStatus.error);
              return;
            }
          } catch (e) {
            return;
          }
          final socialCubit = getIt<SocialCubit>();

          if (socialCubit.allPosts.isEmpty) {
            socialCubit.fetchPosts();
          }
          GoRouter.of(context).push(
            AppRoutes.postDetails,
            extra: {
              'post': post,
              'cubit': socialCubit,
            },
          );
        },
        child: Container(
          width: 230.w,
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            color: isMe
                ? ColorsDark.white.withOpacity(0.15)
                : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: ColorsDark.blueLight1.withOpacity(0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.repeat,
                      size: 16.sp, color: isMe ? Colors.white70 : Colors.grey),
                  SizedBox(width: 4.w),
                  CustomTextWidget(
                    text: "${"post_from".tr()} $userName",
                    textStyle: TextStyle(
                      fontSize: FontDetails.fontSizeXS,
                      fontWeight: FontWeight.bold,
                      color: isMe ? Colors.white70 : Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              if (postImage.isNotEmpty) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: CachedNetworkImage(
                    imageUrl: postImage,
                    height: 120.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      height: 120.h,
                      color: Colors.grey.shade200,
                      child: const Center(
                        child: CircularProgressIndicator(
                            color: ColorsDark.blueLight1),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      height: 120.h,
                      width: double.infinity,
                      color: Colors.grey.shade200,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image_not_supported_outlined,
                            size: 35,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
              ],
              if (postText.isNotEmpty)
                CustomTextWidget(
                  text: postText,
                  maxLines: 3,
                  textStyle: TextStyle(
                    fontSize: FontDetails.fontSizeS,
                    color: isMe ? ColorsLight.white : ColorsLight.black,
                  ),
                ),
            ],
          ),
        ),
      );
    } else if (type == "story_reply") {
      Map<String, dynamic> storyData = {};

      try {
        storyData = jsonDecode(message);
      } catch (e) {
        storyData = {
          'reply_text': message,
          'imageUrl': '',
          'text': "loading_error".tr()
        };
      }

      final String replyText = storyData['reply_text'] ?? "";
      final String storyImage = storyData['imageUrl'] ?? "";
      final String storyText = storyData['text'] ?? "";
      final String ownerName = storyData['storyOwnerName'] ?? "unknow".tr();

      return GestureDetector(
        onTap: () {
          final storyCubit = context.read<StoryCubit>();

          if (storyCubit.state is StoryLoaded) {
            final groups = (storyCubit.state as StoryLoaded).groupedStories;

            final groupIndex =
                groups.indexWhere((g) => g.userId == storyData['userId']);

            if (groupIndex != -1) {
              GoRouter.of(context).push(
                AppRoutes.viewsStory,
                extra: {
                  'cubit': storyCubit,
                  'initialGroupIndex': groupIndex,
                },
              );
            } else {
              AlertService().showAlert(
                  context: context,
                  subtitle: "the_story_is_not_available_right_now".tr(),
                  status: AlertStatus.error);
            }
          }
        },
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
            padding: EdgeInsets.all(10.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: BoxConstraints(maxHeight: 60.h), 
                  decoration: BoxDecoration(
                    color: isMe
                        ? ColorsDark.white.withOpacity(0.15)
                        : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border(
                      right:
                          BorderSide(color: ColorsDark.blueLight1, width: 4.w),
                    ),
                  ),
                  child: Row(
                    children: [
                      if (storyImage.isNotEmpty) ...[
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(6.r),
                            bottomRight: Radius.circular(6.r),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: storyImage,
                            placeholder: (context, url) => SizedBox(
                              width: 60.w, 
                              height: double.infinity, 
                              child: const Center(
                                child: CircularProgressIndicator(
                                    color: ColorsDark.blueLight1),
                              ),
                            ),
                            errorWidget: (context, url, error) => const Icon(
                              Icons.image_not_supported_outlined,
                              size: 30,
                              color: ColorsLight.mainTextColor,
                            ),
                            width: 60.w,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 8.w),
                      ],
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center, 
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.history,
                                      size: 14.sp,
                                      color: isMe
                                          ? Colors.white70
                                          : Colors.grey.shade700),
                                  SizedBox(width: 4.w),
                                  Expanded(
                                    child: CustomTextWidget(
                                      text: "${"replied_to_a_story_of".tr()} $ownerName",
                                      maxLines: 1,
                                      textStyle: TextStyle(
                                        fontSize: FontDetails.fontSizeXS,
                                        fontWeight: FontWeight.bold,
                                        color: isMe
                                            ? Colors.white70
                                            : Colors.grey.shade700,
                                        overflow: TextOverflow.ellipsis, 
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              if (storyText.isNotEmpty) ...[
                                SizedBox(height: 4.h),
                                CustomTextWidget(
                                  text: storyText,
                                  maxLines: 1,
                                  textStyle: TextStyle(
                                    fontSize: FontDetails.fontSizeXS,
                                    color:
                                        isMe ? Colors.white70 : Colors.black54,
                                    overflow: TextOverflow.ellipsis, 
                                  ),
                                ),
                              ]
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.h),
                CustomTextWidget(
                  text: replyText,
                  textStyle: TextStyle(
                    fontSize: FontDetails.fontSizeS,
                    color: isMe ? ColorsLight.white : ColorsLight.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      } else if (type == "product_share") {
      Map<String, dynamic> productData = {};
      try {
        productData = jsonDecode(message);
      } catch (e) {
        productData = {"product_title": "Error loading product".tr()};
      }

      final String productTitle = productData['product_title'] ?? "";
      final String productImage = productData['product_image'] ?? "";
      final String productPrice = productData['price']?.toString() ?? "";

      return GestureDetector(
        onTap: () async {
           ProductModel sharedProduct;
           try {
             sharedProduct = ProductModel.fromJson(productData);
             final productCubit = getIt<ProductCubit>();
             GoRouter.of(context).push(
               AppRoutes.productDetails,
               extra: {'product': sharedProduct, 'cubit': productCubit},
             );
           } catch (e) {
             AlertService().showAlert(context: context, subtitle: "error_opening_product".tr(), status: AlertStatus.error);
           }
        },
        child: Container(
          width: 230.w,
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            color: isMe ? ColorsDark.white.withOpacity(0.15) : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: ColorsDark.blueLight1.withOpacity(0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.shopping_bag_outlined, size: 16.sp, color: isMe ? Colors.white70 : Colors.grey),
                  SizedBox(width: 4.w),
                  CustomTextWidget(
                    text: "product_share".tr(),
                    textStyle: TextStyle(
                      fontSize: FontDetails.fontSizeXS,
                      fontWeight: FontWeight.bold,
                      color: isMe ? Colors.white70 : Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              if (productImage.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: CachedNetworkImage(
                    imageUrl: productImage,
                    height: 120.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      height: 120.h, color: Colors.grey.shade200,
                      child: const Center(child: CircularProgressIndicator(color: ColorsDark.blueLight1)),
                    ),
                    errorWidget: (context, url, error) => const Icon(
                              Icons.image_not_supported_outlined,
                              size: 40,
                              color: ColorsLight.mainTextColor,
                            ),
                          ),
                  ),
              SizedBox(height: 8.h),
              CustomTextWidget(
                text: productTitle,
                maxLines: 2,
                textStyle: TextStyle(fontSize: FontDetails.fontSizeS, fontWeight: FontWeight.bold, color: isMe ? ColorsLight.white : ColorsLight.black),
              ),
              SizedBox(height: 4.h),
              CustomTextWidget(
                text: productPrice,
                textStyle: TextStyle(fontSize: FontDetails.fontSizeS, color: ColorsDark.blueLight1, fontWeight: FontWeight.bold),
              ),
            ],
          ),
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
