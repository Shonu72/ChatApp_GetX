import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_chat/core/utils/failure.dart';
import 'package:get_chat/core/utils/helpers.dart';
import 'package:get_chat/services/api/api_service.dart';
import 'package:get_chat/src/models/api_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthControllers extends GetxController {
  final _apiService = ApiService();
  final errorMessage = RxString('');
  var isLoading = false.obs;

  Future<void> loginUser(String username, String password) async {
    final result = await _apiService.login(username, password);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    result.fold((failure) {
      Helpers.toast("Login Failed");
    }, (success) {
      Helpers.setString(key: "apiToken", value: success["token"]);
      Helpers.toast("Login Successful");
      prefs.setBool("isLoggedIn", true);
    });
  }
}
