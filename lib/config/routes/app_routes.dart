import 'package:chat_app/core/helpers/shared_prefrences.dart';
import 'package:chat_app/features/Login/presentation/manager/login_cubit/login_cubit.dart';
import 'package:chat_app/features/chats/data/data_sources/create_chats_remote_data_source.dart';
import 'package:chat_app/features/chats/presentation/manager/create_chats_cubit/create_chats_cubit.dart';
import 'package:chat_app/features/chats/presentation/manager/get_chats_cubit/get_chats_cubit.dart';
import 'package:chat_app/features/chats/presentation/screens/add_chats.dart';
import 'package:chat_app/features/forget_password/presentation/manager/forget_password_cubit/forget_password_cubit.dart';
import 'package:chat_app/features/forget_password/presentation/screens/forget_password_screen.dart';
import 'package:chat_app/features/Login/presentation/screens/login_screen.dart';
import 'package:chat_app/features/groups/domain/entities/groups_entity.dart';
import 'package:chat_app/features/groups/presentation/manager/groups_cubit/groups_cubit.dart';
import 'package:chat_app/features/groups/presentation/screens/create_group_screen.dart';
import 'package:chat_app/features/main/presentation/manager/main_cubit/main_cubit.dart';
import 'package:chat_app/features/main/presentation/screens/main_screen.dart';
import 'package:chat_app/features/message/presentation/manager/message_cubit/message_cubit.dart';
import 'package:chat_app/features/message/presentation/screens/message_screen.dart';
import 'package:chat_app/features/message_groups/presentation/manager/cubit/messege_group_cubit.dart';
import 'package:chat_app/features/message_groups/presentation/screens/message_groups_screen.dart';
import 'package:chat_app/features/more/screens/manager/cubit/more_cubit.dart';
import 'package:chat_app/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:chat_app/features/sign_up/presentation/manager/sign_up_cubit/sign_up_cubit.dart';
import 'package:chat_app/features/sign_up/presentation/screens/sign_up_screen.dart';
import 'package:chat_app/features/splash/presentation/views/onbording_screen.dart';
import 'package:chat_app/features/splash/presentation/views/splash_screen.dart';
import 'package:chat_app/injection_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String forgotPassword = '/forgotPassword';
  static const String signUp = '/signUp';
  static const String home = '/home';
  static const String message = '/message';
  static const String addChats = '/addChats';
  static const String addGroups = '/addGroups';
  static const String messageGroups = '/messageGroups';

  static final GoRouter router = GoRouter(
    initialLocation: (getIt<CacheHelper>().getData(key: 'isLoggedIn') ?? false)
        ? AppRoutes.home
        : AppRoutes.splash,
    routes: [
      GoRoute(
          path: AppRoutes.splash,
          name: 'splash',
          builder: (context, state) => const SplashScreen()),
      GoRoute(
          path: AppRoutes.onboarding,
          name: 'onboarding',
          builder: (context, state) => const OnboardingScreen()),
      GoRoute(
          path: AppRoutes.login,
          name: 'login',
          builder: (context, state) {
            return BlocProvider(
              create: (context) => getIt<LoginCubit>(),
              child: const LoginScreen(),
            );
          }),
      GoRoute(
          path: AppRoutes.forgotPassword,
          name: 'forgotPassword',
          builder: (context, state) => BlocProvider(
                create: (context) => getIt<ForgetPasswordCubit>(),
                child: const ForgotPasswordScreen(),
              )),
      GoRoute(
          path: AppRoutes.signUp,
          name: 'signUp',
          builder: (context, state) => BlocProvider(
                create: (context) => getIt<SignUpCubit>(),
                child: const SignupScreen(),
              )),
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => getIt<MainCubit>(),
            ),
            BlocProvider(
              create: (context) => getIt<MoreCubit>(),
            ),
            BlocProvider(
              create: (context) => getIt<ProfileCubit>(),
            ),
            BlocProvider(
                create: (context) => getIt<GetChatsCubit>()..fetchChats()),
            BlocProvider(create: (context) => getIt<GroupsCubit>()..fetchGroups()),
          ],
          child: const MainScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.addChats,
        name: 'addChats',
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<CreateChatsCubit>(),
          child: const AddFriendScreen(),
        ),
      ),
      GoRoute(
          path: AppRoutes.message,
          name: 'message',
          builder: (context, state) {
            final args = state.extra as Map<String, dynamic>;
            final String friendId = args['friendId'];

            final myUid = FirebaseAuth.instance.currentUser!.uid;

            final roomId = generateRoomId(myUid, friendId);

            return BlocProvider(
              create: (context) =>
                  getIt<MessageCubit>()..initChat(roomId, friendId),
              child: MessageScreen(
                roomId: roomId,
                friendId: friendId,
              ),
            );
          }),
      GoRoute(
        path: AppRoutes.addGroups,
        name: 'addGroups',
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<GroupsCubit>(),
          child: const CreateGroupScreen(),
        ),
      ),
   GoRoute(
  path: AppRoutes.messageGroups,
  name: 'messageGroups',
  builder: (context, state) {
    if (state.extra is! GroupsEntity) {
      return const Scaffold(
        body: Center(child: Text('Error: Invalid Group Data')),
      );
    }

    final group = state.extra as GroupsEntity;
    
    return BlocProvider(
      create: (context) => getIt<MessegeGroupCubit>()..getMessages(group.id),
      child: MessageGroupsScreen(group: group),
    );
  },
)
    ],
  );
}
