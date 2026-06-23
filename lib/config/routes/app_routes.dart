import 'package:chat_app/config/app/upload_image/presentation/manager/cubit/upload_image_cubit.dart';
import 'package:chat_app/config/routes/based_rout.dart';
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
import 'package:chat_app/features/more/presentation/manager/more_cubit/more_cubit.dart';
import 'package:chat_app/features/post_details/presentation/manager/comments_cubit/comments_cubit.dart';
import 'package:chat_app/features/post_details/presentation/screens/post_details_screen.dart';
import 'package:chat_app/features/products/presentation/manager/cubit/add_product_cubit.dart';
import 'package:chat_app/features/products/presentation/screens/add_product_screen.dart';
import 'package:chat_app/features/products/presentation/screens/product_details_screen.dart';
import 'package:chat_app/features/products/presentation/screens/products_screen.dart';
import 'package:chat_app/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:chat_app/features/sign_up/presentation/manager/sign_up_cubit/sign_up_cubit.dart';
import 'package:chat_app/features/sign_up/presentation/screens/sign_up_screen.dart';
import 'package:chat_app/features/social/domain/entities/social_entity.dart';
import 'package:chat_app/features/social/domain/entities/story_entity.dart';
import 'package:chat_app/features/social/presentation/manager/social_cubit/social_cubit.dart';
import 'package:chat_app/features/social/presentation/manager/story_cubit/story_cubit.dart';
import 'package:chat_app/features/social/presentation/screens/create_or_edit_story_screen.dart';
import 'package:chat_app/features/social/presentation/screens/social_screen.dart';
import 'package:chat_app/features/social/presentation/screens/story_viewer_screen.dart';
import 'package:chat_app/features/splash/presentation/views/onbording_screen.dart';
import 'package:chat_app/features/splash/presentation/views/splash_screen.dart';
import 'package:chat_app/injection_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static bool get _isLoggedIn {
    final cached = getIt<CacheHelper>().getData(key: 'isLoggedIn') ?? false;
    return cached && FirebaseAuth.instance.currentUser != null;
  }

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
  static const String social = '/social';
  static const String postDetails = '/postDetails';
  static const String viewsStory = '/viewsStory';
  static const String createOrEditStory = '/createOrEditStory';
  static const String products = '/products';
  static const String addProduct = '/addProduct';
  static const String productDetails = '/productDetails';

  static final GoRouter router = GoRouter(
    initialLocation: _isLoggedIn ? AppRoutes.home : AppRoutes.splash,
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
          pageBuilder: (context, state) {
            return fadeScaleTransitionPage(
              key: state.pageKey,
              child: MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => getIt<LoginCubit>(),
                  ),
                  BlocProvider(
                    create: (context) => getIt<SignUpCubit>(),
                  ),
                ],
                child: const LoginScreen(),
              ),
            );
          }),
      GoRoute(
          path: AppRoutes.forgotPassword,
          name: 'forgotPassword',
          pageBuilder: (context, state) => fadeScaleTransitionPage(
                key: state.pageKey,
                child: BlocProvider(
                  create: (context) => getIt<ForgetPasswordCubit>(),
                  child: const ForgotPasswordScreen(),
                ),
              )),
      GoRoute(
          path: AppRoutes.signUp,
          name: 'signUp',
          pageBuilder: (context, state) => fadeScaleTransitionPage(
                key: state.pageKey,
                child: BlocProvider(
                  create: (context) => getIt<SignUpCubit>(),
                  child: const SignupScreen(),
                ),
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
              create: (context) => getIt<ProfileCubit>()..getUserData(),
            ),
            BlocProvider(
                create: (context) => getIt<GetChatsCubit>()..fetchChats()),
            BlocProvider(
                create: (context) => getIt<GroupsCubit>()..fetchGroups()),
            BlocProvider(create: (context) => getIt<UploadImageCubit>()),
            BlocProvider(
                create: (context) => getIt<SocialCubit>()..fetchPosts()),
          ],
          child: const MainScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.addChats,
        name: 'addChats',
        pageBuilder: (context, state) => fadeScaleTransitionPage(
          key: state.pageKey,
          child: BlocProvider(
            create: (context) => getIt<CreateChatsCubit>(),
            child: const AddFriendScreen(),
          ),
        ),
      ),
      GoRoute(
          path: AppRoutes.message,
          name: 'message',
          pageBuilder: (context, state) {
            final args = state.extra as Map<String, dynamic>;
            final String friendId = args['friendId'];

            final myUid = FirebaseAuth.instance.currentUser!.uid;

            final roomId = generateRoomId(myUid, friendId);

            return fadeScaleTransitionPage(
              key: state.pageKey,
              child: MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) =>
                        getIt<MessageCubit>()..initChat(roomId, friendId),
                  ),
                  BlocProvider(
                    create: (context) => getIt<SocialCubit>()..fetchPosts(),
                  ),
                  BlocProvider(
                      create: (context) => getIt<StoryCubit>()..fetchStories())
                ],
                child: MessageScreen(
                  roomId: roomId,
                  friendId: friendId,
                ),
              ),
            );
          }),
      GoRoute(
        path: AppRoutes.addGroups,
        name: 'addGroups',
        pageBuilder: (context, state) => fadeScaleTransitionPage(
          key: state.pageKey,
          child: BlocProvider(
            create: (context) => getIt<GroupsCubit>(),
            child: const CreateGroupScreen(),
          ),
        ),
      ),
      GoRoute(
        path: AppRoutes.messageGroups,
        name: 'messageGroups',
        pageBuilder: (context, state) {
          final group = state.extra as GroupsEntity;

          return fadeScaleTransitionPage(
            key: state.pageKey,
            child: BlocProvider(
              create: (context) =>
                  getIt<MessegeGroupCubit>()..getMessages(group.id),
              child: MessageGroupsScreen(group: group),
            ),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.social,
        name: 'social',
        pageBuilder: (context, state) {
          return fadeScaleTransitionPage(
            key: state.pageKey,
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => getIt<SocialCubit>()..fetchPosts(),
                ),
                BlocProvider(
                  create: (context) => getIt<ProfileCubit>()..getUserData(),
                ),
                BlocProvider(
                    create: (context) => getIt<StoryCubit>()..fetchStories())
              ],
              child: const SocialScreen(),
            ),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.postDetails,
        name: 'postDetails',
        pageBuilder: (context, state) {
          final extraData = state.extra as Map<String, dynamic>;
          final post = extraData['post'] as SocialEntity;
          final socialCubit = extraData['cubit'] as SocialCubit;
          return fadeScaleTransitionPage(
            key: state.pageKey,
            child: MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: socialCubit,
                ),
                BlocProvider(
                  create: (context) => getIt<ProfileCubit>()..getUserData(),
                ),
                BlocProvider(
                    create: (context) =>
                        getIt<CommentsCubit>()..fetchComments(post.id)),
              ],
              child: PostDetailsScreen(
                post: post,
              ),
            ),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.viewsStory,
        name: 'viewsStory',
        pageBuilder: (context, state) {
          final extraData = state.extra as Map<String, dynamic>;
          final groupIndex = extraData['initialGroupIndex'] as int;
          final storyCubit = extraData['cubit'] as StoryCubit;

          return fadeScaleTransitionPage(
            key: state.pageKey,
            child: BlocProvider.value(
              value: storyCubit,
              child: StoryViewerScreen(initialGroupIndex: groupIndex),
            ),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.createOrEditStory,
        name: 'createOrEditStory',
        pageBuilder: (context, state) {
          final extraData = state.extra as Map<String, dynamic>;
          final storyCubit = extraData['cubit'] as StoryCubit;
          final storyToEdit = extraData['storyToEdit'] as StoryEntity?;

          return fadeScaleTransitionPage(
            key: state.pageKey,
            child: BlocProvider.value(
              value: storyCubit,
              child: CreateOrEditStoryScreen(storyToEdit: storyToEdit),
            ),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.products,
        name: 'products',
        pageBuilder: (context, state) {
          return fadeScaleTransitionPage(
              key: state.pageKey, child: const ProductsScreen());
        },
      ),
      GoRoute(
        path: AppRoutes.addProduct,
        name: 'addProduct',
        pageBuilder: (context, state) {
          return fadeScaleTransitionPage(
              key: state.pageKey,
              child: BlocProvider(
                create: (context) => getIt<AddProductCubit>(),
                child: const AddProductScreen(),
              ));
        },
      ),
      GoRoute(
        path: AppRoutes.productDetails,
        name: 'productDetails',
        pageBuilder: (context, state) {
          return fadeScaleTransitionPage(
              key: state.pageKey, child: const ProductDetailsScreen());
        },
      )
    ],
  );
}
