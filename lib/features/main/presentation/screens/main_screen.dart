import 'package:chat_app/config/routes/app_routes.dart';
import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/enum/nav_bar_enum.dart';
import 'package:chat_app/features/chats/presentation/screens/chats_screen.dart';
import 'package:chat_app/features/groups/presentation/screens/groups_screen.dart';
import 'package:chat_app/features/main/presentation/manager/main_cubit/main_cubit.dart';
import 'package:chat_app/features/main/presentation/screens/widget/custom_app_bar.dart';
import 'package:chat_app/features/main/presentation/screens/widget/custom_bottom_nav_bar.dart';
import 'package:chat_app/features/main/presentation/screens/widget/social_floating_action_button.dart';
import 'package:chat_app/features/more/presentation/screens/more_screen.dart';
import 'package:chat_app/features/profile/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _RootState();
}

class _RootState extends State<MainScreen> {
  late PageController controller;
  late List<Widget> screens;
  int currentScreen = 0;

  @override
  void initState() {
    screens = [
      const ChatsScreen(),
      const GroupsScreen(),
      const ProfileScreen(),
      const MoreScreen(),
    ];
    controller = PageController(initialPage: currentScreen);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        int currentIndex =
            BlocProvider.of<MainCubit>(context).currentNavBar.index;
        return Scaffold(
          backgroundColor: context.color.mainColor,
          appBar: customNavBar(context),
          body: PageView(
            controller: controller,
            // physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (index) {
              NavBarEnum selectedEnum = NavBarEnum.values[index];
              BlocProvider.of<MainCubit>(context)
                  .selectedNavBarIcons(selectedEnum);
              controller.jumpToPage(index);
            },
            children: screens,
          ),
          bottomNavigationBar: CustomBottomNavBar(
            currentScreen: currentIndex,
            onTabTapped: (index) {
              NavBarEnum selectedEnum = NavBarEnum.values[index];
              BlocProvider.of<MainCubit>(context)
                  .selectedNavBarIcons(selectedEnum);
              controller.jumpToPage(index);
            },
          ),
          floatingActionButton: (currentIndex == 0 || currentIndex == 1)
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SocialFloatingActionButton(
                      icon: Icons.public,
                      heroTag: 'social_fab_tag',
                      onPressed: () {
                        GoRouter.of(context).push(AppRoutes.social);
                      },
                    ),
                    SizedBox(height: 15.h),
                    SocialFloatingActionButton(
                        icon: Icons.production_quantity_limits,
                        heroTag: 'products_fab_tag',
                        onPressed: () {
                          GoRouter.of(context).push(AppRoutes.products);
                        })
                  ],
                )
              : null,
        );
      },
    );
  }
}
