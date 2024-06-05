import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_chat/core/themes/colors.dart';
import 'package:get_chat/core/utils/exception.dart';
import 'package:get_chat/core/utils/failure.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum RequestType { get, post }

enum statuc {
  success,
  failed,
  loading,
  networkError,
  error,
  load,
}

class Helpers {
  void showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }
   static toast(String msg, {ToastGravity? gravity}) {
    FocusManager.instance.primaryFocus?.unfocus();
    return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: gravity ?? ToastGravity.BOTTOM,
      backgroundColor: textLightColor,
      textColor: Colors.white,
      fontSize: 16,
    );
  }

  static setString({required String key, required String value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

   static String convertFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return failure.message;
    }
    return "Unknown error occurred";
  }


  
}
