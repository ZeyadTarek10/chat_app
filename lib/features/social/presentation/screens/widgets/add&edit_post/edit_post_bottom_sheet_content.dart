import 'package:chat_app/config/app/upload_image/presentation/screens/widgets/image_pick.dart';
import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/enum/alert_enum.dart';
import 'package:chat_app/core/services/alert_service.dart';
import 'package:chat_app/core/services/animate_do.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/features/social/domain/entities/social_entity.dart';
import 'package:chat_app/features/social/presentation/manager/social_cubit/social_cubit.dart';
import 'package:chat_app/features/social/presentation/screens/widgets/add&edit_post/action_item_add_post_bottom_sheet.dart';
import 'package:chat_app/shared_widgets/buttons/custom_linear_btn.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:chat_app/shared_widgets/custom_text_form_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class EditPostBottomSheetContent extends StatefulWidget {
  final SocialEntity post;
  const EditPostBottomSheetContent({super.key, required this.post});

  @override
  State<EditPostBottomSheetContent> createState() =>
      _EditPostBottomSheetContentState();
}

class _EditPostBottomSheetContentState
    extends State<EditPostBottomSheetContent> {
  @override
  void initState() {
    super.initState();
    context.read<SocialCubit>().initEditData(widget.post);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {
        if (state is SocialActionSuccess) {
          Navigator.pop(context);
          AlertService().showAlert(
                context: context,
                subtitle: "the_post_has_been_successfully_edited".tr(),
                status: AlertStatus.success);
        } else if (state is SocialError) {
          AlertService().showAlert(
                context: context,
                subtitle: state.message,
                status: AlertStatus.error);
        }
      },
      builder: (context, state) {
        final cubit = context.read<SocialCubit>();
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CustomTextWidget(
                  text: "edit_post".tr(),
                  textStyle: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontDetails.boldFontWeight,
                    color: context.color.textColor,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              CustomTextFormFieldWidget(
                hint: "edit_your_post".tr(),
                controller: cubit.textController,
                textColor: context.color.textColor,
                fillColor: context.color.chatBackgroundColor,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "leave_a_comment".tr();
                  }
                  return null;
                },
              ),
              SizedBox(height: 15.h),
              CustomFadeInUp(
                duration: 300,
                child: Row(
                  children: [
                    Expanded(
                      child: ActionItemAddPostBottomSheet(
                        onTap: state is SocialImageUploading
                            ? null
                            : () async {
                                final image = await PickImageUtils()
                                    .pickImage(ImageSource.gallery);
                                if (image != null) {
                                  cubit.uploadSelectedImage(image);
                                }
                              },
                        icon: state is SocialImageUploading
                            ? Icons.cloud_upload_outlined
                            : (cubit.selectedImage != null ||
                                    cubit.uploadedImageUrl != null)
                                ? Icons.check_circle
                                : Icons.image_outlined,
                        text: state is SocialImageUploading
                            ? "uploading".tr()
                            : (cubit.selectedImage != null ||
                                    cubit.uploadedImageUrl != null)
                                ? "image_selected".tr()
                                : "photo".tr(),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: ActionItemAddPostBottomSheet(
                        onTap: state is SocialLocationLoading
                            ? null
                            : () {
                                cubit.fetchLocation();
                              },
                        icon: state is SocialLocationLoading
                            ? Icons.sync
                            : Icons.location_on_outlined,
                        text: state is SocialLocationLoading
                            ? "selecting".tr()
                            : cubit.currentLocation.isNotEmpty
                                ? cubit.currentLocation
                                : "location".tr(),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25.h),
              CustomLinearButton(
                onPressed: () {
                  if (cubit.textController.text.isNotEmpty &&
                      state is! SocialImageUploading) {
                    cubit.updatePost(
                        widget.post, cubit.textController.text);
                  }
                },
                height: 50.h,
                width: double.infinity.w,
                child: state is SocialLoading
                    ? const CircularProgressIndicator(color: ColorsDark.white)
                    : CustomTextWidget(
                        text: 'update'.tr(),
                        textStyle: TextStyle(
                          fontSize: FontDetails.fontSizeM,
                          color: ColorsDark.white,
                          fontWeight: FontDetails.boldFontWeight,
                        ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
