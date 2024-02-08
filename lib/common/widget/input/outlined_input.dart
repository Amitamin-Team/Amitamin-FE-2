import 'package:amitamin_frontend/common/const/const.dart';
import 'package:flutter/material.dart';

class OutlinedInput extends StatelessWidget {
  const OutlinedInput({
    Key? key,
    this.onChanged,
    this.hintText = '',
    this.keyboardType,
    this.obscureText = false,
    this.enabled = true,
  }) : super(key: key);

  final void Function(String)? onChanged;
  final String hintText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: TextFormField(
        enabled: enabled,
        onChanged: onChanged,
        keyboardType: keyboardType,
        obscureText: obscureText,
        enableSuggestions: false,
        autocorrect: false,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12.0,
            horizontal: 12.0,
          ),
        ),
        style: TextStyle(
          fontFamily: CustomText.body4.fontFamily,
          fontWeight: CustomText.body4.fontWeight,
          fontSize: CustomText.body4.fontSize,
          color: CustomColor.extraDarkGray,
          decorationThickness: 0,
        ),
        cursorColor: CustomColor.primaryBlue100,
      ),
    );
  }
}
