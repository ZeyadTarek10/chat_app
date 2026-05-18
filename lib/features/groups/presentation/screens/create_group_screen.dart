import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/services/animate_do.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/app_images.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/core/validations/app_validation.dart';
import 'package:chat_app/features/groups/presentation/manager/groups_cubit/groups_cubit.dart';
import 'package:chat_app/features/groups/presentation/screens/widgets/add_member_to_group_button.dart';
import 'package:chat_app/features/groups/presentation/screens/widgets/add_members_sheet.dart';
import 'package:chat_app/features/groups/presentation/screens/widgets/create_group_button.dart';
import 'package:chat_app/features/groups/presentation/screens/widgets/list_view_builder_add_member_group.dart';
import 'package:chat_app/shared_widgets/custom_buttom_sheet.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:chat_app/shared_widgets/custom_text_form_field.dart';
import 'package:chat_app/shared_widgets/show_snack_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CreateGroupScreen extends StatelessWidget {
  const CreateGroupScreen({super.key});

  void showAddMembersSheet(BuildContext context) {
    context.read<GroupsCubit>().fetchAvailableUsers();
    CustomBottomSheet.showModalBottomSheetContainer(
          context: context,
          widget: BlocProvider.value(
            value: BlocProvider.of<GroupsCubit>(context),
            child: const AddMembersSheet(),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.color.mainColor,
        flexibleSpace: Image.asset(
          AppImages.bG,
          fit: BoxFit.cover,
        ),
        leading: GestureDetector(
          onTap: () => GoRouter.of(context).pop(),
          child: Center(
            child: Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                color: ColorsDark.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_back, color: ColorsDark.white),
            ),
          ),
        ),
        title: CustomTextWidget(
          text: 'create_group'.tr(),
          textStyle: TextStyle(
            color: ColorsDark.white,
            fontSize: 18.sp,
            fontWeight: FontDetails.semiBoldFontWeight,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<GroupsCubit, GroupsState>(
        listener: (context, state) {
          if (state is GroupsSuccess) {
            showSnackBar(context,
                text: "the_group_was_successfully_created".tr(),
                color: ColorsLight.green);
            GoRouter.of(context).pop();
          } else if (state is GroupsError) {
            showSnackBar(context, text: state.error, color: ColorsLight.error);
          }
        },
        builder: (context, state) {
          var cubit = context.read<GroupsCubit>();
          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomFadeInRight(
                        duration: 600,
                        child: CustomTextWidget(
                            text: "name_group".tr(),
                            textStyle: const TextStyle(color: ColorsLight.mainTextColor)),
                      ),
                      SizedBox(height: 8.w),
                      CustomFadeInRight(
                        duration: 600,
                        child: CustomTextFormFieldWidget(
                          hint: "enter_name_group".tr(),
                          onChange: (val) => cubit.updateName(val),
                          withBorders: true,
                          validator: (String? value) =>
                              AppValidator.nameValidation(value),
                        ),
                      ),
                      SizedBox(height: 25.h),
                      CustomFadeInDown(
                        duration: 200,
                        child: GestureDetector(
                          onTap: () => showAddMembersSheet(context),
                          child: const AddMemberToGroupButton(),
                        ),
                      ),
                      Expanded(
                        child: ListViewBuilderAddMemberGroup(cubit: cubit),
                      ),
                    ],
                  ),
                ),
              ),
              CustomFadeInUp(
                duration: 200,
                child: CreateGroupButton(cubit: cubit)),
            ],
          );
        },
      ),
    );
  }
}

