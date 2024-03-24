import 'package:amitamin_frontend/common/const/const.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void messageToast(context, message) {
  FToast fToast = FToast();
  fToast.init(context);

  Widget toast = Container(
    width: MediaQuery.of(context).size.width * 0.8,
    height: 45,
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.0),
      color: CustomColor.lightBlack,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          width: 12.0,
        ),
        Text(
          '$message',
          style: TextStyle(
            fontSize: CustomText.button.fontSize,
            fontWeight: CustomText.button.fontWeight,
            fontFamily: CustomText.button.fontFamily,
            color: CustomColor.white
          ),
        ),
        const SizedBox(
          width: 12.0,
        ),
      ],
    ),
  );


  FToast().showToast(
    child: toast,
    gravity: ToastGravity.BOTTOM,
    toastDuration: const Duration(seconds: 2),
  );
}