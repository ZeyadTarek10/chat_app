import 'package:chat_app/config/app/app_cubit/app_cubit.dart';
import 'package:chat_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void selectBirthday(BuildContext context, TextEditingController birthdayController) async {
  final isDark = context.read<AppCubit>().isDark; 

  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime(2000, 1, 1),
    firstDate: DateTime(1920),
    lastDate: DateTime.now(),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: isDark
              ? const ColorScheme.dark(
                  primary: ColorsDark.blueLight2,
                  onPrimary: Colors.white,        
                  onSurface: Colors.white,        
                )
              : const ColorScheme.light(
                  primary: ColorsDark.blueLight2, 
                  onPrimary: Colors.white,
                  onSurface: ColorsLight.mainTextColor, 
                ),
        ),
        child: child!,
      );
    },
  );

  if (pickedDate != null) {
    String formattedDate =
        "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}";

    birthdayController.text = formattedDate;
  }
}