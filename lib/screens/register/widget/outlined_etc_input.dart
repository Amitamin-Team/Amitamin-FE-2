import 'package:flutter/material.dart';

import 'package:amitamin_frontend/common/common.dart';
import 'package:flutter/services.dart';

class OutlinedEtcInput extends StatelessWidget {
  const OutlinedEtcInput({
    Key? key,
    this.controller,
    this.onChanged,
    this.hintText = '',
    this.keyboardType,
    this.obscureText = false,
    this.enabled = true,
  }) : super(key: key);

  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String hintText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      onChanged: onChanged,
      keyboardType: keyboardType,
      obscureText: obscureText,
      enableSuggestions: false,
      autocorrect: false,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12.0,
        ),
      ),
      style: TextStyle(
        color: CustomColor.extraDarkGray,
        fontSize: 14,
        fontWeight: CustomText.body4.fontWeight,
        decorationThickness: 0,
      ),
      cursorColor: CustomColor.primaryBlue100,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp('[.!@#\$%^&*()-_|1-9|a-z|A-Z|ㄱ-ㅎ|ㅏ-ㅣ|가-힣|ᆞ|ᆢ|ㆍ|ᆢ|ᄀᆞ|ᄂᆞ|ᄃᆞ|ᄅᆞ|ᄆᆞ|ᄇᆞ|ᄉᆞ|ᄋᆞ|ᄌᆞ|ᄎᆞ|ᄏᆞ|ᄐᆞ|ᄑᆞ|ᄒᆞ]')),
      ],
    );
  }
}
