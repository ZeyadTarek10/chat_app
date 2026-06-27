import 'package:chat_app/config/routes/app_routes.dart';
import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/features/message/presentation/manager/message_cubit/message_cubit.dart';
import 'package:chat_app/features/products/domain/entities/product_entity.dart';
import 'package:chat_app/injection_container.dart';
import 'package:chat_app/shared_widgets/buttons/custom_linear_btn.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ProductDetailsScreenBottomCartSection extends StatelessWidget {
  final ProductEntity productEntity;
  final String currentUserId;
  const ProductDetailsScreenBottomCartSection(
      {super.key, required this.productEntity, required this.currentUserId});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.color.mainColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextWidget(
                        text: "total_price".tr(),
                        textStyle: TextStyle(
                            fontWeight: FontDetails.boldFontWeight,
                            color: context.color.textColor,
                            fontSize: FontDetails.fontSizeM)),
                  ],
                ),
                CustomTextWidget(
                  text: productEntity.price,
                  textStyle: TextStyle(
                      fontWeight: FontDetails.boldFontWeight,
                      color: context.color.textColor,
                      fontSize: 18.sp),
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 65.h,
            child: CustomLinearButton(
              radius: 0,
              onPressed: () async {
                List<String> members = [currentUserId, productEntity.userId]
                  ..sort((a, b) => a.compareTo(b));
                String finalRoomId = members.join();

                final messageCubit = getIt<MessageCubit>();
                await messageCubit.sendProductsMessage(
                  roomId: finalRoomId,
                  friendId: productEntity.userId,
                  product: productEntity,
                );

                if (context.mounted) {
                  GoRouter.of(context).push(AppRoutes.message, extra: {
                    'roomId': finalRoomId,
                    'friendId': productEntity.userId,
                  });
                }
              },
              child: CustomTextWidget(
                text: "chat_with_me".tr(),
                textStyle: TextStyle(
                    color: ColorsDark.white,
                    fontSize: FontDetails.fontSizeM,
                    fontWeight: FontDetails.boldFontWeight),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
