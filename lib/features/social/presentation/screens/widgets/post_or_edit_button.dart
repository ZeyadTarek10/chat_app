import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/features/social/domain/entities/story_entity.dart';
import 'package:chat_app/features/social/presentation/manager/story_cubit/story_cubit.dart';
import 'package:chat_app/shared_widgets/buttons/elevated_btn_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';

class PostOrEditButton extends StatelessWidget {
  final TextEditingController textController;
  final bool hasAnyImage;
  final StoryCubit cubit;
  final XFile? selectedImg;
  final bool hasNetworkImage;
  final int selectedClr;
  final StoryEntity? storyToEdit;
  final bool isLoading;

  const PostOrEditButton({
    super.key,
    required this.textController,
    required this.hasAnyImage,
    required this.cubit,
    required this.selectedImg,
    required this.hasNetworkImage,
    required this.selectedClr,
    this.storyToEdit,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: isLoading
          ? const CircularProgressIndicator(color: ColorsDark.white)
          : CustomElevatedButtonWidget(
              btnWidth: 100.w,
              btnHeight: 40.h,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: ColorsDark.white,
                    width: 1.5.w,
                  ),
                ),
              ),
              text: storyToEdit != null ? 'update'.tr() : 'post'.tr(),
              textStyle: const TextStyle(
                color: ColorsDark.white,
                fontWeight: FontWeight.bold,
              ),
              onPressed: () {
                if (textController.text.isEmpty && !hasAnyImage) return;

                FocusScope.of(context).unfocus();

                cubit.saveStory(
                  text: textController.text.trim(),
                  storyIdToUpdate: storyToEdit?.id,
                  selectedImage: selectedImg,
                  existingImageUrl:
                      hasNetworkImage ? storyToEdit!.imageUrl : null,
                  selectedColor: selectedClr,
                );
              },
            ),
    );
  }
}