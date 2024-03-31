import 'package:amitamin_frontend/common/const/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OutlinedInput extends StatelessWidget {
  const OutlinedInput({
    Key? key,
    this.controller,
    this.onChanged,
    this.hintText = '',
    this.keyboardType,
    this.obscureText = false,
    this.enabled = true,
    this.validator,
    this.errorText,
    this.inputFormatter,
    this.enabledBorder,
    this.focusedBorder,
  }) : super(key: key);

  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String hintText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool enabled;
  final String? Function(String?)? validator;
  final String? errorText;
  final List<TextInputFormatter>? inputFormatter;
  final Color? enabledBorder;
  final Color? focusedBorder;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: TextFormField(
        controller: controller,
        validator: validator,
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
          errorText: errorText,
          errorStyle: const TextStyle(color: CustomColor.error, fontSize: 13),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: enabledBorder ?? CustomColor.lightGray),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(width: 1, color: focusedBorder ?? CustomColor.primaryBlue100),
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
        inputFormatters: inputFormatter ?? [
          FilteringTextInputFormatter.allow(RegExp('[.!@#\$%^&*()|1-9|a-z|A-Z|ㄱ-ㅎ|ㅏ-ㅣ|가-힣|ᆞ|ᆢ|ㆍ|ᆢ|ᄀᆞ|ᄂᆞ|ᄃᆞ|ᄅᆞ|ᄆᆞ|ᄇᆞ|ᄉᆞ|ᄋᆞ|ᄌᆞ|ᄎᆞ|ᄏᆞ|ᄐᆞ|ᄑᆞ|ᄒᆞ]')),
        ],
      ),
    );
  }
}
