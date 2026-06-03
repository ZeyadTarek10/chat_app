import 'package:chat_app/core/enum/nav_bar_enum.dart';
import 'package:chat_app/features/main/presentation/manager/main_cubit/main_cubit.dart';
import 'package:chat_app/features/main/presentation/screens/widget/add_app_bar.dart';
import 'package:chat_app/features/main/presentation/screens/widget/search_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

PreferredSizeWidget customNavBar(BuildContext context) {
  return PreferredSize(
    preferredSize: Size.fromHeight(60.h),
    child: BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        final cubit = BlocProvider.of<MainCubit>(context);
        if (cubit.isSearching) {
          return SearchAppBar(cubit: cubit);
        } else if (NavBarEnum.profile == cubit.currentNavBar) {
          return const AppBarMore();
        } else if (NavBarEnum.more == cubit.currentNavBar){
          return const AppBarMore();
        }
        return AddAppBar(cubit: cubit);
      },
    ),
  );
}
