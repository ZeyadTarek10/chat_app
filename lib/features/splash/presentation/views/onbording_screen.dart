import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/config/routes/app_routes.dart';
import 'package:chat_app/features/splash/data/onboarding_model.dart';
import 'package:chat_app/features/splash/presentation/views/widgets/onboarding_controls.dart';
import 'package:chat_app/features/splash/presentation/views/widgets/onboarding_page_content.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;


  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

   void navigateToLogin(BuildContext context) {
    GoRouter.of(context).pushReplacement(AppRoutes.login);
  }
  @override
  Widget build(BuildContext context) {
      final List<OnboardingModel> pages = [
    OnboardingModel(
      title: 'group_chatting'.tr(),
      description: 'connect_with_multiple_members_in_group_chats'.tr(),
      imagePath: context.images.onbording!,
    ),
    OnboardingModel(
      title: 'video_and_voice_calls'.tr(),
      description: 'instantly_connect_via_video_and_voice_calls'.tr(),
      imagePath: context.images.onbording1!,
    ),
    OnboardingModel(
      title: 'message_encryption'.tr(),
      description: 'ensure_privacy_with_encrypted_messages'.tr(),
      imagePath: context.images.onbording2!,
    ),
    OnboardingModel(
      title: 'cross_platform_compatibility'.tr(),
      description: 'access_chats_on_any_device_seamlessly'.tr(),
      imagePath: context.images.onbording3!,
    ),
  ];

    return Scaffold(
      backgroundColor: context.color.mainColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemCount: pages.length,
                itemBuilder: (context, index) {
                  return OnboardingPageContent(model: pages[index]);
                },
              ),
            ),

            Expanded(
              flex: 2,
              child: OnboardingControls(
                currentPage: _currentPage,
                totalPages: pages.length,
                onGetStarted: () => navigateToLogin(context),
                onSkip: () {
                  _pageController.jumpToPage(pages.length - 1);
                },
                onNext: () {
                  if (_currentPage < pages.length - 1) {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    navigateToLogin(context);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}