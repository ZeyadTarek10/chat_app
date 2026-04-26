import 'package:chat_app/features/more/screens/widgets/custom_more_tile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguageMoreScreen extends StatelessWidget {
  const LanguageMoreScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomMoreTile(
      icon: Icons.text_format,
      title: 'language'.tr(),
      trailing: PopupMenuButton<Locale>(
        color: Colors.white,
        initialValue: context.locale,
        onSelected: (Locale newLocale) {
          context.setLocale(newLocale);
        },
        itemBuilder: (BuildContext context) =>
            <PopupMenuEntry<Locale>>[
          const PopupMenuItem<Locale>(
            value: Locale('en'),
            child: Text('English'),
          ),
          const PopupMenuItem<Locale>(
            value: Locale('ar'),
            child: Text('العربية'),
          ),
        ],
        child: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                context.locale.languageCode == 'ar'
                    ? 'العربية'
                    : 'English',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.keyboard_arrow_down, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}
