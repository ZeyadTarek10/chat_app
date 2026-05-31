import 'package:chat_app/config/routes/app_routes.dart';
import 'package:chat_app/config/themes/app_theme.dart';
import 'package:chat_app/features/groups/presentation/manager/groups_cubit/groups_cubit.dart';
import 'package:chat_app/features/groups/presentation/screens/widgets/groups_item.dart';
import 'package:chat_app/features/main/presentation/manager/main_cubit/main_cubit.dart';
import 'package:chat_app/shared_widgets/custom_loading.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String myUid = FirebaseAuth.instance.currentUser!.uid;
    return BlocBuilder<GroupsCubit, GroupsState>(
      builder: (context, state) {
        if (state is GroupsLoading) {
          return const CustomLoading();
        } else if (state is GroupsLoaded) {
          if (state.groups.isEmpty) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/lottie/Share.json'),
                CustomTextWidget(
                    text: "there_are_no_groups_now".tr(),
                    textStyle: appTheme().textTheme.displayMedium),
              ],
            ));
          }
          final searchQuery =
              context.watch<MainCubit>().searchQuery.toLowerCase();
          final filteredGroups = state.groups.where((group) {
            final name = group.name.toLowerCase();
            return name.contains(searchQuery);
          }).toList();
          if (filteredGroups.isEmpty) {
            return Center(
                child: Lottie.asset('assets/lottie/non data found.json'));
          }
          return ListView.builder(
            itemCount: filteredGroups.length,
            padding: EdgeInsets.only(top: 8.r, bottom: 20.r),
            itemBuilder: (context, index) {
              final group = filteredGroups[index];

              int currentUnreadCount = group.unreadCounts?[myUid] ?? 0;
              return GestureDetector(
                onTap: () {
                  GoRouter.of(context)
                      .push(AppRoutes.messageGroups, extra: group);
                },
                child: GroupsItem(
                  name: group.name,
                  message: group.lastMessage.isNotEmpty
                      ? group.lastMessage
                      : 'start_chatting'.tr(),
                  time: context
                      .read<GroupsCubit>()
                      .formatGroupTime(group.lastMessageTime),
                  unreadCount: currentUnreadCount,
                  image: group.image,
                  c: group.memberNames.length,
                  memberNames: group.memberNames,
                ),
              );
            },
          );
        } else if (state is GroupsError) {
          return Center(
              child: CustomTextWidget(
                  text: "there_is_an_error ${state.error}".tr()));
        }

        return const SizedBox();
      },
    );
  }
}
