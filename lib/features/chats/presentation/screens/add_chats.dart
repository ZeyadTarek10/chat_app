import 'package:chat_app/config/routes/app_routes.dart';
import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/services/animate_do.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/app_images.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/features/chats/presentation/manager/create_chats_cubit/create_chats_cubit.dart';
import 'package:chat_app/features/chats/presentation/screens/widgets/search_content_area.dart';
import 'package:chat_app/features/chats/presentation/screens/widgets/search_create_chate_text_field.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:chat_app/shared_widgets/show_snack_bar.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AddFriendScreen extends StatefulWidget {
  const AddFriendScreen({super.key});

  @override
  State<AddFriendScreen> createState() => _AddFriendScreenState();
}

class _AddFriendScreenState extends State<AddFriendScreen> {
  late CreateChatsCubit createChatsCubit;

  @override
  void initState() {
    super.initState();
    createChatsCubit = context.read<CreateChatsCubit>();
    createChatsCubit.phoneController.clear();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.mainColor,
      appBar: AppBar(
        toolbarHeight: 65.h,
        backgroundColor: context.color.mainColor,
        flexibleSpace: Image.asset(AppImages.bG, fit: BoxFit.cover,),
        leading: Padding(
          padding: EdgeInsets.only(bottom: 12.h, left: 8.w, right: 8.w),          
          child: GestureDetector(
            onTap: () => GoRouter.of(context).pop(),
            child: Center(
              child: Container(
                padding: EdgeInsets.all(5.r),
                decoration: BoxDecoration(
                  color: ColorsLight.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back, color: ColorsLight.white),
              ),
            ),
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: CustomTextWidget(
            text: 'add_friend'.tr(),
            textStyle: TextStyle(
              color: ColorsLight.white,
              fontSize: 18.sp,
              fontWeight: FontDetails.semiBoldFontWeight,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<CreateChatsCubit, CreateChatsState>(
        listener: (context, state) {
          if (state is CreateChatsSuccessState) {
            GoRouter.of(context).pushReplacement(AppRoutes.home);
          } else if (state is CreateChatsErrorState) {
            showSnackBar(context, text: state.errMsg, color: ColorsLight.error);
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    SizedBox(height: 25.h),
                    CustomFadeInLeft(
                      duration: 400,
                      child: SearchCreateChateTextField(
                        phoneController: createChatsCubit.phoneController,
                        onChangedPicker: (CountryCode countryCode) {
                          createChatsCubit
                              .updateCountryCode(countryCode.dialCode ?? '+20');
                        },
                        onChangeTextField: (value) {
                          if (value.isNotEmpty && value.length > 9) {
                            createChatsCubit.searchUsers(value.trim());
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Expanded(
                      child: SearchContentArea(state: state),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
