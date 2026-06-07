import 'package:chat_app/config/app/app_cubit/app_cubit.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/features/more/presentation/screens/widgets/custom_more_tile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DarkModeMoreScreen extends StatelessWidget {
  const DarkModeMoreScreen({
    super.key,
    required this.cubit,
  });

  final AppCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      bloc: cubit,
      builder: (context, state) {
        return CustomMoreTile(
          icon: CupertinoIcons.moon,
          title: 'dark_mode'.tr(),
          trailing: CupertinoSwitch(
            value: cubit.isDark,
            activeTrackColor: ColorsDark.blueLight1,
            onChanged: (val) =>
                cubit.changeAppThemeMode('dark_mode', sharedMode: val),
          ),
        );
      },
    );
  }
}
