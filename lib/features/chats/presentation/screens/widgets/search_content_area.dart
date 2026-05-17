import 'package:chat_app/config/themes/app_theme.dart';
import 'package:chat_app/core/utils/app_images.dart';
import 'package:chat_app/features/chats/presentation/manager/create_chats_cubit/create_chats_cubit.dart';
import 'package:chat_app/features/chats/presentation/screens/widgets/user_result_search_item.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class SearchContentArea extends StatelessWidget {
  final CreateChatsState state;

  const SearchContentArea({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final createChatsCubit = context.read<CreateChatsCubit>();

    if (state is CreateChatsInitial ||
        (createChatsCubit.phoneController.text.isEmpty &&
            state is! UsersSearchSuccessState)) {
      return Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppImages.cardsearch, width: 220.w),
              SizedBox(height: 50.h),
            ],
          ),
        ),
      );
    }

    if (state is UsersSearchingState) {
      return Lottie.asset('assets/lottie/Loading Dots Blue.json');
    }

    if (state is UsersSearchSuccessState) {
      final users = (state as UsersSearchSuccessState).foundUsers;

      if (users.isEmpty) {
        return Center(child: Column(
          children: [
            Lottie.asset('assets/lottie/non data found.json'),
            CustomTextWidget(text: "no_user_found_with_this_phone".tr(), textStyle: appTheme().textTheme.displayMedium),
          ],
        ));
      }

      return ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        itemCount: users.length,
        separatorBuilder: (context, index) => SizedBox(height: 15.h),
        itemBuilder: (context, index) {
          final user = users[index];
          return UserResultSearchItem(
            user: user,
            onPressed: () {
              createChatsCubit.createChat(user.phone);
            },
          );
        },
      );
    }

    return const SizedBox();
  }
}
