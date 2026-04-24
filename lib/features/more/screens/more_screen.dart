import 'package:chat_app/config/routes/app_routes.dart';
import 'package:chat_app/features/more/screens/manager/cubit/more_cubit.dart';
import 'package:chat_app/features/more/screens/widgets/custom_more_tile.dart';
import 'package:chat_app/features/more/screens/widgets/dark_mode_more_screen.dart';
import 'package:chat_app/features/more/screens/widgets/hide_chat_history_more_screen.dart';
import 'package:chat_app/features/more/screens/widgets/language_more_screen.dart';
import 'package:chat_app/features/more/screens/widgets/log_out_more_screen.dart';
import 'package:chat_app/features/more/screens/widgets/mute_ntification_more_screen.dart';
import 'package:chat_app/features/more/screens/widgets/security_more_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(state.errorMessage), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        final cubit = BlocProvider.of<MoreCubit>(context);

        return SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const LanguageMoreScreen(),
              DarkModeMoreScreen(cubit: cubit),
              MuteNtificationMoreScreen(cubit: cubit),
              CustomMoreTile(
                icon: CupertinoIcons.bell,
                title: 'Custom Notification',
                onTap: () {},
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Divider(color: Colors.grey.shade200, thickness: 1),
              ),
              CustomMoreTile(
                icon: CupertinoIcons.person_add,
                title: 'Invite Friends',
                onTap: () {},
              ),
              CustomMoreTile(
                icon: CupertinoIcons.group,
                title: 'Joined Groups',
                onTap: () {},
              ),
              HideChatHistoryMoreScreen(cubit: cubit),
              SecurityMoreScreen(cubit: cubit),
              CustomMoreTile(
                icon: CupertinoIcons.doc_text,
                title: 'Term of Service',
                onTap: () {},
              ),
              CustomMoreTile(
                icon: CupertinoIcons.square_stack_3d_down_right,
                title: 'About App',
                onTap: () {},
              ),
              CustomMoreTile(
                icon: CupertinoIcons.question_circle,
                title: 'Help Center',
                onTap: () {},
              ),
              const SizedBox(height: 10),
              LogOutMoreScreen(cubit: cubit),
              const SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }
}











