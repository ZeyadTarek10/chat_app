import 'package:chat_app/config/routes/app_routes.dart';
import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/features/social/presentation/manager/social_cubit/social_cubit.dart';
import 'package:chat_app/features/social/presentation/screens/widgets/post_card.dart';
import 'package:chat_app/shared_widgets/custom_loading.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ListViewBuilderPostCard extends StatelessWidget {
  const ListViewBuilderPostCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialCubit, SocialState>(
      builder: (context, state) {
        final cubit = context.read<SocialCubit>();
        final posts = cubit.allPosts;

        if (state is SocialLoading) {
          return const SliverToBoxAdapter(
            child: Center(child: CustomLoading()),
          );
        }

        if (state is SocialError) {
          return SliverToBoxAdapter(
            child: Center(
                child: CustomTextWidget(
              text: state.message,
              textStyle: TextStyle(
                  color: ColorsLight.error,
                  fontSize: FontDetails.fontSizeS,
                  fontWeight: FontDetails.boldFontWeight),
            )),
          );
        }

        if (posts.isEmpty) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 50.h),
              child: Center(
                child: CustomTextWidget(
                  text: "there_are_no_posts_currently".tr(),
                  textStyle: TextStyle(
                    color: context.color.textColor,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
          );
        }

        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final post = posts[index];
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
            childCount: posts.length,
          ),
        );
      },
    );
  }
}
