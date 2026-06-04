import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/features/social/presentation/screens/widgets/app_bar_social_screen.dart';
import 'package:chat_app/features/social/presentation/screens/widgets/floating_action_button_social_screen.dart';
import 'package:chat_app/features/social/presentation/screens/widgets/list_view_builder_post_card.dart';
import 'package:chat_app/features/social/presentation/screens/widgets/trending_section.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SocialScreen extends StatelessWidget {
  const SocialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.color.mainColor,
        floatingActionButton: const FloatingActionButtonSocialScreen(),
        body: CustomScrollView(
          slivers: [
            const AppBarSocialScreen(),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 16.0.w, vertical: 8.0.h),
                    child: CustomTextWidget(
                      text: 'trending'.tr(),
                      textStyle: TextStyle(
                          fontSize: FontDetails.fontSizeM,
                          fontWeight: FontDetails.mediumFontWeight,
                          color: context.color.textColor),
                    ),
                  ),
                  const TrendingSection(),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
            const ListViewBuilderPostCard(),
            SliverToBoxAdapter(
              child: SizedBox(height: 10.h),
            ),
          ],
        )
        );
  }
}
