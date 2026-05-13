import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/features/more/screens/manager/cubit/more_cubit.dart';
import 'package:chat_app/features/more/screens/widgets/custom_more_tile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SecurityMoreScreen extends StatelessWidget {
  const SecurityMoreScreen({
    super.key,
    required this.cubit,
  });

  final MoreCubit cubit;

  @override
  Widget build(BuildContext context) {
    return CustomMoreTile(
      icon: CupertinoIcons.shield,
      title: 'security'.tr(),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CupertinoSwitch(
            value: cubit.isSecurityEnabled,
            activeTrackColor: ColorsDark.blueLight1,
            onChanged: (val) => cubit.toggleSwitch('security', val),
          ),
          SizedBox(width: 8.w),
          Icon(CupertinoIcons.chevron_right,
              fontWeight: FontDetails.regularFontWeight,
              color: ColorsLight.black, size: 20.sp),
        ],
      ),
    );
  }
}