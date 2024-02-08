import 'package:amitamin_frontend/common/const/const.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void messageToast(context, message) {
  FToast fToast = FToast();
  fToast.init(context);

  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.0),
      color: CustomColor.black,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 25,
          height: 25,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.asset(
              'assets/main/ic_logo.png',
              fit: BoxFit.fill,
            ),
          ),
        ),
        const SizedBox(
          width: 12.0,
        ),
        Text(
          '$message',
          style: CustomText.button
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