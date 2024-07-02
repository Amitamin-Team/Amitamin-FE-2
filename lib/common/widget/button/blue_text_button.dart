import 'package:amitamin_frontend/common/const/const.dart';
import 'package:flutter/material.dart';

class BlueTextButton extends StatelessWidget {
  const BlueTextButton({
    Key? key,
    this.disabled = true,
    this.onPressed,
    required this.text,
    this.disabledBackgroundColor = CustomColor.white,
    this.disabledBorderColor = CustomColor.primaryBlue100,
    this.disabledTextColor = CustomColor.primaryBlue100,
  }) : super(key: key);

  final String text;
  final bool disabled;
  final VoidCallback? onPressed;
  final Color? disabledBackgroundColor;
  final Color? disabledBorderColor;
  final Color? disabledTextColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 47,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: disabled ? disabledBackgroundColor : CustomColor.primaryBlue100,
          side: BorderSide(
            width: 1,
            color: disabledBorderColor ?? CustomColor.primaryBlue100,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: CustomText.body4.fontFamily,
            fontWeight: CustomText.body4.fontWeight,
            fontSize: CustomText.body4.fontSize,
            color: disabled ? disabledTextColor : CustomColor.white,
          ),
        ),
      ),
    );
  }
}
