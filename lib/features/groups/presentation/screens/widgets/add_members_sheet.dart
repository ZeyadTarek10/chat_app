import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/services/animate_do.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/features/groups/presentation/manager/groups_cubit/groups_cubit.dart';
import 'package:chat_app/features/groups/presentation/screens/widgets/check_box_list_tile.dart';
import 'package:chat_app/shared_widgets/buttons/custom_linear_btn.dart';
import 'package:chat_app/shared_widgets/buttons/elevated_btn_widget.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:chat_app/shared_widgets/custom_text_form_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class AddMembersSheet extends StatelessWidget {
  const AddMembersSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupsCubit, GroupsState>(
      builder: (context, state) {
        var cubit = context.read<GroupsCubit>();
        var displayedContacts = cubit.filteredContacts;
        return Container(
          color: context.color.navBarbg,
          height: MediaQuery.of(context).size.height * 0.8,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              CustomFadeInDown(
                duration: 400,
                child: CustomTextWidget(
                    text: "add_members_to_group".tr(),
                    textStyle: TextStyle(
                        fontWeight: FontDetails.boldFontWeight,
                        fontSize: 16.sp,
                        color: context.color.textColor)),
              ),
              SizedBox(height: 15.h),
              CustomFadeInDown(
                duration: 400,
                child: CustomTextFormFieldWidget(
                  withBorders: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'enter_your_name_or_phone'.tr();
                    }
                    return null;
                  },
                  hint: 'search'.tr(),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  onChange: (value) {
                    cubit.updateMemberSearchQuery(value);
                  },
                ),
              ),
              SizedBox(height: 15.h),
              Expanded(
                child: state is GroupsUsersLoading
                    ? Lottie.asset("assets/lottie/Loading Dots Blue.json")
                    : cubit.contacts.isEmpty
                        ? Center(
                            child: CustomTextWidget(
                                text: "there_are_no_users_to_add".tr(),
                                textStyle:
                                    TextStyle(color: context.color.textColor)))
                        : displayedContacts.isEmpty
                            ? Center(
                                child: Lottie.asset(
                                    'assets/lottie/non data found.json'))
                            : ListView.builder(
                                itemCount: displayedContacts.length,
                                itemBuilder: (context, index) {
                                  var contact = displayedContacts[index];

                                  String imageUrl = contact['image'] ?? "";
                                  String initial = contact['name']
                                          .toString()
                                          .trim()
                                          .isNotEmpty
                                      ? contact['name']
                                          .toString()
                                          .trim()[0]
                                          .toUpperCase()
                                      : "?";

                                  return CheckBoxListTile(
                                    contact: contact,
                                    imageUrl: imageUrl,
                                    initial: initial,
                                    cubit: cubit,
                                    index: cubit.contacts.indexOf(contact),
                                  );
                                },
                              ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomFadeInRight(
                      duration: 400,
                      child: CustomElevatedButtonWidget(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: ColorsDark.addMemberButtonLightBlue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.r)),
                        ),
                        onPressed: () => Navigator.pop(context),
                        btnWidth: 60.w,
                        btnHeight: 60.h,
                        text: 'cancel'.tr(),
                        textStyle: TextStyle(
                            color: ColorsDark.blueLight2, fontSize: 16.sp),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Expanded(
                    child: CustomFadeInLeft(
                      duration: 400,
                      child: CustomLinearButton(
                        onPressed: () {
                          cubit.confirmSelection();
                          Navigator.pop(context);
                        },
                        height: 60.h,
                        width: double.infinity.w,
                        child: CustomTextWidget(
                          text: 'add'.tr(),
                          textStyle: TextStyle(
                            fontSize: FontDetails.fontSizeM,
                            color: ColorsDark.white,
                            fontWeight: FontDetails.boldFontWeight,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
            ],
          ),
        );
      },
    );
  }
}
