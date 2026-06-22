import 'package:chat_app/config/routes/app_routes.dart';
import 'package:chat_app/features/social/presentation/manager/social_cubit/social_cubit.dart';
import 'package:chat_app/features/social/presentation/screens/widgets/posts/post_card.dart';
import 'package:chat_app/shared_widgets/custom_loading.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class UserPostsSection extends StatelessWidget {
  final String userId;
  const UserPostsSection({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialCubit, SocialState>(
      builder: (context, state) {
        if (state is SocialLoaded) {
          final cubit = context.read<SocialCubit>();
          final userPosts =
              cubit.allPosts.where((post) => post.userId == userId).toList();

          if (userPosts.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: CustomTextWidget(text: "no_posts_yet".tr()),
              ),
            );
          }

          return ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: userPosts.length,
            separatorBuilder: (context, index) => SizedBox(height: 15.h),
            itemBuilder: (context, index) {
              final post = userPosts[index];
              return GestureDetector(
                onTap: () {
                  GoRouter.of(context).push(
                    AppRoutes.postDetails,
                    extra: {
                      'post': post,
                      'cubit': cubit,
                    },
                  );
                },
                child: PostCard(post: post),
              );
            },
          );
        } else if (state is SocialLoading) {
          return const Center(child: CustomLoading());
        } else if (state is SocialError) {
          return Center(
            child: CustomTextWidget(text: state.message),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
