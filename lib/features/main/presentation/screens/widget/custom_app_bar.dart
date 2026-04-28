import 'package:chat_app/features/main/presentation/manager/main_cubit/main_cubit.dart';
import 'package:chat_app/features/main/presentation/screens/widget/add_app_bar.dart';
import 'package:chat_app/features/main/presentation/screens/widget/search_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


PreferredSizeWidget customNavBar(BuildContext context) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(kToolbarHeight),
    child: BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        final cubit = BlocProvider.of<MainCubit>(context);
        if (cubit.isSearching) {
          return SearchAppBar(cubit: cubit);
        }
        return AddAppBar(cubit: cubit);
      },
    ),
  );
}






