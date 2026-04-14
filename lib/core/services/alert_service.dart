import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../shared_widgets/custom_text.dart';
import '../enum/alert_enum.dart';
import '../utils/app_colors.dart';

class AlertService {
  void showAlert({
    required BuildContext context,
    required String title,
    required String subtitle,
    required AlertStatus status,
  }) {
    FToast().init(context).showToast(
          gravity: ToastGravity.BOTTOM,
          toastDuration: const Duration(seconds: 5),
          child: Container(
            width: 350.w,
            constraints: BoxConstraints(maxHeight: 110.h),
            padding: EdgeInsets.all(10.w),
            margin: EdgeInsets.only(bottom: 20.w),
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(
                  color: status == AlertStatus.success ? AppColors.green : AppColors.error),
              borderRadius: BorderRadius.all(Radius.circular(12.r)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                status == AlertStatus.success ? const Icon(Icons.done) : const Icon(Icons.error),
                10.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextWidget(
                        text: title,
                        maxLines: 2,
                        textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color:
                                status == AlertStatus.success ? AppColors.green : AppColors.error),
                      ),
                      CustomTextWidget(
                        text: subtitle,
                        maxLines: 3,
                        textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color:
                                status == AlertStatus.success ? AppColors.green : AppColors.error),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () => FToast().removeCustomToast(),
                  child: const Icon(Icons.close),
                ),
              ],
            ),
          ),
        );
  }
}
