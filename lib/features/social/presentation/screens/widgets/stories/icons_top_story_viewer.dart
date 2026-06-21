import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class IconsTopStoryViewer extends StatelessWidget {
  const IconsTopStoryViewer({
    super.key,
    required this.onClose,
    required this.isMyStory,
    required this.onDelete,
    required this.onEdit,
  });

  final VoidCallback onClose;
  final bool isMyStory;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.close, color: ColorsDark.white),
          onPressed: onClose,
        ),
        if (isMyStory)
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: ColorsDark.white),
            onSelected: (value) {
              if (value == 'delete') {
                onDelete();
              } else if (value == 'edit') {
                onEdit();
              }
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                  value: 'edit', child: CustomTextWidget(text: 'edit'.tr())),
              PopupMenuItem(
                value: 'delete',
                child: CustomTextWidget(
                    text: 'delete'.tr(),
                    textStyle: const TextStyle(color: ColorsLight.red)),
              ),
            ],
          ),
      ],
    );
  }
}
