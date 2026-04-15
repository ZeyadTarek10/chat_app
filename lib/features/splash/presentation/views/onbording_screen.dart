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

  final List<OnboardingModel> _pages = [
    OnboardingModel(
      title: 'Group Chatting',
      description: 'Connect with multiple members in group chats.',
      imagePath: 'onbording.png',
    ),
    OnboardingModel(
      title: 'Video And Voice Calls',
      description: 'Instantly connect via video and voice calls.',
      imagePath: 'onbording1.png',
    ),
    OnboardingModel(
      title: 'Message Encryption',
      description: 'Ensure privacy with encrypted messages.',
      imagePath: 'onbording2.png',
    ),
    OnboardingModel(
      title: 'Cross-Platform\nCompatibility',
      description: 'Access chats on any device seamlessly.',
      imagePath: 'onbording3.png',
    ),
  ];

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
    return Scaffold(
      backgroundColor: Colors.white,
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
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return OnboardingPageContent(model: _pages[index]);
                },
              ),
            ),

            Expanded(
              flex: 2,
              child: OnboardingControls(
                currentPage: _currentPage,
                totalPages: _pages.length,
                onGetStarted: () => navigateToLogin(context),
                onSkip: () {
                  _pageController.jumpToPage(_pages.length - 1);
                },
                onNext: () {
                  if (_currentPage < _pages.length - 1) {
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