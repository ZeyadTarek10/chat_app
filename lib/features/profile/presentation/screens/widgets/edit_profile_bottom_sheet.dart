import 'package:chat_app/core/utils/app_colors.dart';
import 'package:chat_app/core/utils/font_details.dart';
import 'package:chat_app/core/validations/app_validation.dart';
import 'package:chat_app/features/profile/presentation/screens/widgets/action_edit_buttons.dart';
import 'package:chat_app/features/profile/presentation/screens/widgets/custom_drop_down_button_field.dart';
import 'package:chat_app/features/profile/presentation/screens/widgets/select_birthday.dart';
import 'package:chat_app/features/sign_up/domain/entities/user_entity.dart';
import 'package:chat_app/shared_widgets/custom_text.dart';
import 'package:chat_app/shared_widgets/custom_text_form_field.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateDonorBottomSheet extends StatefulWidget {
  const CreateDonorBottomSheet({super.key, required this.currentUser});
  final UserEntity currentUser;

  @override
  State<CreateDonorBottomSheet> createState() => _CreateDonorBottomSheetState();
}

class _CreateDonorBottomSheetState extends State<CreateDonorBottomSheet> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.currentUser.name;
    phoneController.text = widget.currentUser.phone;
    genderController.text = widget.currentUser.gender;
    birthdayController.text = widget.currentUser.birthday;
    emailController.text = widget.currentUser.email;
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    genderController.dispose();
    birthdayController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 20.h,
        left: 20.w,
        right: 20.w,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
      ),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: CustomTextWidget(
                  text: 'edit_profile'.tr(),
                  textStyle: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontDetails.semiBoldFontWeight,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              CustomTextWidget(
                text: 'name'.tr(),
                textStyle: TextStyle(
                    fontSize: FontDetails.fontSizeS,
                    fontWeight: FontDetails.regularFontWeight),
              ),
              SizedBox(height: 8.h),
              CustomTextFormFieldWidget(
                controller: nameController,
                hint: 'name'.tr(),
                withBorders: true,
                validator: (name) => AppValidator.nameValidation(name),
              ),
              SizedBox(height: 20.h),
              CustomTextWidget(
                text: 'phone_number'.tr(),
                textStyle: TextStyle(
                    fontSize: FontDetails.fontSizeS,
                    fontWeight: FontDetails.regularFontWeight),
              ),
              SizedBox(height: 8.h),
              CustomTextFormFieldWidget(
                controller: phoneController,
                hint: '100000000',
                withBorders: true,
                textInputType: TextInputType.phone,
                validator: (value) => AppValidator.phoneValidation(value),
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CountryCodePicker(
                        onChanged: (CountryCode countryCode) {
                          (countryCode.dialCode ?? '+20');
                        },
                        initialSelection: 'EG',
                        favorite: const ['+20', 'EG', '+44', 'GB'],
                        showCountryOnly: false,
                        showOnlyCountryWhenClosed: false,
                        alignLeft: false,
                        padding: EdgeInsets.zero,
                        flagWidth: 24.w,
                        textStyle: TextStyle(
                            color: AppColors.mainTextColor,
                            fontSize: FontDetails.fontSizeS),
                      ),
                      Icon(Icons.keyboard_arrow_down,
                          size: 20.sp, color: AppColors.mainTextColor),
                      SizedBox(width: 4.w),
                      Container(
                        height: 24.h,
                        width: 1.w,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      SizedBox(width: 8.w),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              CustomTextWidget(
                text: 'gender'.tr(),
                textStyle: TextStyle(
                    fontSize: FontDetails.fontSizeS,
                    fontWeight: FontDetails.regularFontWeight),
              ),
              SizedBox(height: 8.h),
              CustomDropDownButtonFormField(genderController: genderController),
              SizedBox(height: 20.h),
              CustomTextWidget(
                text: 'birthday'.tr(),
                textStyle: TextStyle(
                    fontSize: FontDetails.fontSizeS,
                    fontWeight: FontDetails.regularFontWeight),
              ),
              SizedBox(height: 8.h),
              GestureDetector(
                onTap: () {
                  selectBirthday(context, birthdayController);
                },
                child: AbsorbPointer(
                  child: CustomTextFormFieldWidget(
                    controller: birthdayController,
                    hint: 'DD/MM/YYYY',
                    withBorders: true,
                    readOnly: true,
                    suffixIcon: Icon(Icons.calendar_today_outlined,
                        color: AppColors.mainTextColor),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please_select_your_birthday'.tr();
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              CustomTextWidget(
                text: 'email'.tr(),
                textStyle: TextStyle(
                    fontSize: FontDetails.fontSizeS,
                    fontWeight: FontDetails.regularFontWeight),
              ),
              SizedBox(height: 8.h),
              CustomTextFormFieldWidget(
                controller: emailController,
                hint: 'john@gmail.com',
                withBorders: true,
                textInputType: TextInputType.emailAddress,
                validator: (value) => AppValidator.emailValidation(value),
              ),
              SizedBox(height: 30.h),
              ActionEditButtons(
                  formKey: formKey,
                  widget: widget,
                  nameController: nameController,
                  phoneController: phoneController,
                  genderController: genderController,
                  birthdayController: birthdayController,
                  emailController: emailController),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }
}
