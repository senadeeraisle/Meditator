import 'package:flutter/material.dart';
import 'package:meditator/utils/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String lableText;
  final String? hintText;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyBoardType;
  const CustomTextFormField({
    super.key,
    required this.lableText,
    this.hintText,
    this.onSaved,
    this.validator,
    this.keyBoardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onSaved: onSaved,
      keyboardType: keyBoardType,
      decoration: InputDecoration(
        labelText: lableText,
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide(
            color: AppColors.kPrimaryGrey.withValues(alpha: 0.6),
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: const BorderSide(color: AppColors.kPrimaryGrey, width: 2),
        ),
      ),
    );
  }
}
