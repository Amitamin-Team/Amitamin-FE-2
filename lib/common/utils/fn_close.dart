import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

DateTime? backButtonPressedTime;

Future<bool> fnClose(){

  DateTime now = DateTime.now();

  if(backButtonPressedTime == null || now.difference(backButtonPressedTime!)
      > const Duration(seconds: 2))
  {

    backButtonPressedTime = now;
    const message = "'뒤로'버튼 한 번 더 누르시면 종료됩니다.";

    Fluttertoast.showToast(msg: message);
    return Future.value(false);
  }
  SystemNavigator.pop();
  return Future.value(true);
}