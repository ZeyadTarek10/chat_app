import 'package:chat_app/config/app/cubit/app_cubit.dart';
import 'package:chat_app/config/routes/app_routes.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/features/more/screens/manager/cubit/more_cubit.dart';
import 'package:chat_app/features/more/screens/widgets/custom_more_tile.dart';
import 'package:chat_app/features/more/screens/widgets/dark_mode_more_screen.dart';
import 'package:chat_app/features/more/screens/widgets/language_more_screen.dart';
import 'package:chat_app/features/more/screens/widgets/log_out_more_screen.dart';
import 'package:chat_app/shared_widgets/show_snack_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoreCubit, MoreState>(
      listener: (context, state) {
        if (state is LogoutLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        } else if (state is LogoutSuccess) {
          GoRouter.of(context).pop();
          GoRouter.of(context).pushReplacement(AppRoutes.login);
        } else if (state is LogoutFailure) {
          GoRouter.of(context).pop();
          showSnackBar(context, text: state.errorMessage, color: ColorsLight.red);
        }
      },
      builder: (context, state) {
        final cubit = BlocProvider.of<MoreCubit>(context);
        final cubit2 = context.read<AppCubit>();

        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20.h),
              const LanguageMoreScreen(),
              DarkModeMoreScreen(cubit: cubit2),
              // MuteNtificationMoreScreen(cubit: cubit),
              // CustomMoreTile(
              //   icon: CupertinoIcons.bell,
              //   title: 'custom_notification'.tr(),
              //   onTap: () {},
              // ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 24.w),
                child: Divider(color: Colors.grey.shade400, thickness: 0.5),
              ),
              CustomMoreTile(
                icon: CupertinoIcons.person_add,
                title: 'invite_friends'.tr(),
                onTap: () {},
              ),
              CustomMoreTile(
                icon: CupertinoIcons.group,
                title: 'joined_groups'.tr(),
                onTap: () {},
              ),
              // HideChatHistoryMoreScreen(cubit: cubit),
              // SecurityMoreScreen(cubit: cubit),
              // CustomMoreTile(
              //   icon: CupertinoIcons.doc_text,
              //   title: 'term_of_service'.tr(),
              //   onTap: () {},
              // ),
              CustomMoreTile(
                icon: CupertinoIcons.square_stack_3d_down_right,
                title: 'about_app'.tr(),
                onTap: () {},
              ),
              CustomMoreTile(
                icon: CupertinoIcons.question_circle,
                title: 'help_center'.tr(),
                onTap: () {},
              ),
              LogOutMoreScreen(cubit: cubit),
              SizedBox(height: 20.h),
            ],
          ),
        );
      },
    );
  }
}











