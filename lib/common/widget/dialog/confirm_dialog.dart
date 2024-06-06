import 'package:amitamin_frontend/common/const/const.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

showConfirmDialog({
  required BuildContext context,
  required String middleText,
  required VoidCallback onConfirm,
  bool barrierDismissible = true,
}) {
  showDialog(
    barrierDismissible: barrierDismissible, // 바깥 영역 터치 시 -> true : 창닫기 O, false :  창닫기 X 
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  height: 110,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          middleText,
                          style: CustomText.body1,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 1,
                color: CustomColor.lightGray,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8 / 2,
                    height: 50,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16))
                    ),
                    child: InkWell(
                      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(16)),
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
                  Container(
                    width: 1,
                    height: 50,
                    color: CustomColor.lightGray,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8 / 2,
                    height: 50,
                    child: InkWell(
                      borderRadius: const BorderRadius.only(bottomRight: Radius.circular(16)),
                      onTap: () {
                        context.pop();
                        onConfirm();
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "확인",
                            style: CustomText.body7
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
  });
}