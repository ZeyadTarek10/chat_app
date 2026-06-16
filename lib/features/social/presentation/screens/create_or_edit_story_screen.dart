import 'dart:io';
import 'package:chat_app/core/app_constants/story_constants.dart';
import 'package:chat_app/core/enum/alert_enum.dart';
import 'package:chat_app/core/services/alert_service.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/features/social/domain/entities/story_entity.dart';
import 'package:chat_app/features/social/presentation/manager/story_cubit/story_cubit.dart';
import 'package:chat_app/features/social/presentation/screens/widgets/image_story.dart';
import 'package:chat_app/features/social/presentation/screens/widgets/list_of_color_story.dart';
import 'package:chat_app/features/social/presentation/screens/widgets/post_or_edit_button.dart';
import 'package:chat_app/features/social/presentation/screens/widgets/upload_image_icons_story.dart';
import 'package:chat_app/shared_widgets/custom_text_form_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class CreateOrEditStoryScreen extends StatefulWidget {
  final StoryEntity? storyToEdit;
  const CreateOrEditStoryScreen({super.key, this.storyToEdit});

  @override
  State<CreateOrEditStoryScreen> createState() =>
      _CreateOrEditStoryScreenState();
}

class _CreateOrEditStoryScreenState extends State<CreateOrEditStoryScreen> {
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController =
        TextEditingController(text: widget.storyToEdit?.text ?? '');

    context.read<StoryCubit>().initDraft(widget.storyToEdit);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<StoryCubit>();

    return BlocConsumer<StoryCubit, StoryState>(
      listenWhen: (previous, current) =>
          current is StoryActionSuccess || current is StoryError,
      listener: (context, state) {
        if (state is StoryError) {
          AlertService().showAlert(
              context: context,
              subtitle: state.message,
              status: AlertStatus.error);
        } else if (state is StoryActionSuccess) {
          if (GoRouter.of(context).canPop()) GoRouter.of(context).pop();
          AlertService().showAlert(
              context: context,
              subtitle: "the_story_was_added_successfully".tr(),
              status: AlertStatus.success);
        }
      },
      builder: (context, state) {
        XFile? selectedImg = cubit.currentDraftImage;
        int selectedClr = cubit.currentDraftColor;

        final hasLocalImage = selectedImg != null;
        final hasNetworkImage =
            widget.storyToEdit?.imageUrl != null && !hasLocalImage;
        final hasAnyImage = hasLocalImage || hasNetworkImage;

        return Scaffold(
          backgroundColor: hasAnyImage ? ColorsLight.black : Color(selectedClr),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: const IconThemeData(color: ColorsDark.white),
            actions: [
              PostOrEditButton(
                textController: _textController,
                hasAnyImage: hasAnyImage,
                cubit: cubit,
                selectedImg: selectedImg,
                hasNetworkImage: hasNetworkImage,
                selectedClr: selectedClr,
                storyToEdit: widget.storyToEdit,
                isLoading: state is StoryActionLoading,
              ),
            ],
          ),
          extendBodyBehindAppBar: true,
          body: Stack(
            alignment: Alignment.center,
            children: [
              if (hasLocalImage)
                Positioned.fill(
                    child:
                        Image.file(File(selectedImg.path), fit: BoxFit.cover)),
              if (hasNetworkImage)
                Positioned.fill(
                  child: ImageStory(imageUrl: widget.storyToEdit!.imageUrl!),
                ),
              if (hasAnyImage)
                Positioned.fill(
                    child: Container(color: Colors.black.withOpacity(0.4))),
              Center(
                child: CustomTextFormFieldWidget(
                  controller: _textController,
                  hint: "write_a_story".tr(),
                  textAlign: TextAlign.center,
                  withBorders: false,
                  fillColor: Colors.transparent,
                  textColor: Colors.white,
                  hintColor: Colors.white70,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  validator: (value) => null,
                  textInputType: TextInputType.multiline,
                ),
              ),
              if (!hasAnyImage)
                Positioned(
                  top: 100,
                  right: 10,
                  child: ListOfColorStory(
                      backgroundColors: StoryConstants.backgroundColors,
                      cubit: cubit,
                      selectedClr: selectedClr),
                ),
              Positioned(
                bottom: 30,
                child: UploadImageIconsStory(
                    cubit: cubit, hasAnyImage: hasAnyImage),
              ),
            ],
          ),
        );
      },
    );
  }
}

