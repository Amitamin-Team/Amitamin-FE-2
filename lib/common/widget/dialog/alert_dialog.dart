import 'package:amitamin_frontend/common/const/const.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

showAlertDialog({
  required BuildContext context,
  required String middleText
}) {
  showDialog(
    context: context, 
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8 + 1,
          height: 161,
          child: Column(
            children: [
              SizedBox(
                height: 110,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      middleText,
                      style: CustomText.body1,
                    ),
                  ],
                ),
              ),
              Container(
                height: 1,
                color: CustomColor.lightGray,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 50,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16))
                ),
                child: InkWell(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  onTap: () {
                    context.pop();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "닫기",
                        style: TextStyle(
                        fontSize: CustomText.body7.fontSize,
                        fontWeight: CustomText.body7.fontWeight,
                        fontFamily: CustomText.body7.fontFamily,
                        color: CustomColor.extraDarkGray),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  });
}