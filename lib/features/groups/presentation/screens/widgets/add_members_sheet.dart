import 'package:chat_app/core/app_constants/context_ext.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/features/groups/presentation/manager/groups_cubit/groups_cubit.dart';
import 'package:chat_app/shared_widgets/buttons/custom_linear_btn.dart';
import 'package:chat_app/shared_widgets/buttons/elevated_btn_widget.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddMembersSheet extends StatelessWidget {
  const AddMembersSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupsCubit, GroupsState>(
      builder: (context, state) {
        var cubit = context.read<GroupsCubit>();
        return Container(
          color: context.color.navBarbg,
          height: MediaQuery.of(context).size.height * 0.8,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 10.h),
              Container(
                  width: 60.w,
                  height: 5.h,
                  decoration: BoxDecoration(
                      color: context.color.textColor!.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10.r))),
              SizedBox(height: 20.h),
              CustomTextWidget(
                  text: "add_members_to_group".tr(),
                  textStyle: TextStyle(
                      fontWeight: FontDetails.boldFontWeight, fontSize: 16.sp, color: context.color.textColor)),
              SizedBox(height: 15.h),
              Expanded(
                child: state is GroupsUsersLoading
                    ? const Center(child: CircularProgressIndicator())
                    : cubit.contacts.isEmpty
                        ? Center(
                            child: CustomTextWidget(
                                text: "there_are_no_users_to_add".tr(), textStyle: TextStyle(color: context.color.textColor)))
                        : ListView.builder(
                            itemCount: cubit.contacts.length,
                            itemBuilder: (context, index) {
                              var contact = cubit.contacts[index];

                              String imageUrl = contact['image'] ?? "";
                              String initial =
                                  contact['name'].toString().trim().isNotEmpty
                                      ? contact['name']
                                          .toString()
                                          .trim()[0]
                                          .toUpperCase()
                                      : "?";

                              return CheckboxListTile(
                                value: contact['selected'],
                                title: CustomTextWidget(text: contact['name'], textStyle: TextStyle(color: context.color.textColor)),
                                subtitle: CustomTextWidget(text: contact['phone'], textStyle: TextStyle(color: context.color.textColor)),
                                secondary: CircleAvatar(
                                  backgroundColor: ColorsDark.blueDark.withOpacity(0.5),
                                  backgroundImage: imageUrl.isNotEmpty
                                      ? NetworkImage(imageUrl)
                                      : null,
                                  child: imageUrl.isEmpty
                                      ? CustomTextWidget(text: initial,
                                          textStyle: TextStyle(
                                              color: ColorsDark.white,
                                              fontWeight: FontDetails.boldFontWeight))
                                      : null,
                                ),
                                onChanged: (val) {
                                  cubit.toggleContact(index, val ?? false);
                                },
                                activeColor: ColorsDark.blueLight1,
                                checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(5)),
                              );
                            },
                          ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
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
                          color: ColorsDark.blueLight2,
                          fontSize: 16.sp),
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                
                  Expanded(
                    child: CustomLinearButton(onPressed: () {
                        cubit.confirmSelection();
                        Navigator.pop(context);
                      }, height: 60.h,
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
