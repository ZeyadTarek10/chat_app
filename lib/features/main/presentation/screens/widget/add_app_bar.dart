import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/app_images.dart';
import 'package:chat_app/features/main/presentation/manager/main_cubit/main_cubit.dart';
import 'package:chat_app/features/main/presentation/screens/widget/add_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddAppBar extends StatelessWidget {
  const AddAppBar({
    super.key,
    required this.cubit,
  });

  final MainCubit cubit;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.color.mainColor,
      flexibleSpace: Image.asset(AppImages.bG, fit: BoxFit.cover,),
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Image.asset(
          AppImages.appLogoImgHomeDark,
          fit: BoxFit.contain,
        ),
      ),
      leadingWidth: 130,
      actions: [
        IconButton(
          onPressed: () {
            cubit.toggleSearch();
          },
          icon: const Icon(CupertinoIcons.search, color: ColorsLight.white, size: 26),
        ),
        
        AddButton(cubit: cubit),
        const SizedBox(width: 8),
      ],
    );
  }
}
