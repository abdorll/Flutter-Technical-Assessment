import 'package:kooha/helpers/alerts.dart';
import 'package:kooha/screens/nav_screens/nav_screens.dart';
import 'package:kooha/services/api_basics.dart';
import 'package:kooha/services/request_type.dart';
import 'package:kooha/services/response_data.dart';
import 'package:kooha/utils/application_state.dart';
import 'package:kooha/utils/constants.dart';
import 'package:kooha/utils/endpoints.dart';
//import 'package:kooha/views/navs_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:kooha/utils/functions.dart';

Future setFrechLogin({bool newVal = false}) async {
  var user = await Hive.openBox(Constants.USER_BOX);
  user.put(Constants.FRESH_LOGIN, newVal);
}

Future<bool> getFrechLogin() async {
  var user = await Hive.openBox(Constants.USER_BOX);
  bool freshLogin = user.get(Constants.FRESH_LOGIN) ?? false;
  return freshLogin;
}

enum EmailValidity { invalid, isValid, processing, neutral }

class LoginProvider extends GetxController {
  static RxString email = ''.obs, password = ''.obs;
  static EmailValidity emailValidity = EmailValidity.neutral;
  static EmailValidity get getEmailValidity => emailValidity;
  final formKey = GlobalKey<FormState>();
  static set setEmailValidity(EmailValidity validity) =>
      emailValidity = validity;
  static setValidEmail() {
    if (email.value.isEmpty) {
      setEmailValidity = EmailValidity.neutral;
    } else if (!email.value.isEmail && email.value.isNotEmpty) {
      setEmailValidity = EmailValidity.processing;
    } else if (email.value.isEmail) {
      setEmailValidity = EmailValidity.isValid;
    } else {
      setEmailValidity = EmailValidity.invalid;
    }
  }

  LoginProvider() {
    setValidEmail();
  }

  RxBool rememberMe = false.obs;
  ResponseData? loginResponse;
  String? Function(String?)? emailValidator = (_) {
    if (email.value.isEmpty) {
      return "Email is required";
    } else if (!email.value.isEmail) {
      return "Something seems to be wrong here";
    }
    return null;
  };
  String? Function(String?)? passwordValidator = (_) {
    if (password.value.isEmpty) {
      return "Password is required";
    } else if (password.value.length < 8) {
      return "Password must contain 8 characters!";
    }
    return null;
  };
  set setEmailValidator(String Function(String?)? validator) =>
      emailValidator = validator;
  set setPasswordValidator(String Function(String?)? validator) =>
      passwordValidator = validator;
  ApplicationState appState = ApplicationState.NEUTRAL;
  set setLoginResponse(ResponseData data) => loginResponse = data;
  set setAppState(ApplicationState state) => appState = state;
  final ApiBasics _apiBasics = ApiBasics();
  bool isNull(String? value) {
    return (value == "" || value == null);
  }

  Future login(BuildContext context) async {
    setAppState = ApplicationState.LOADING;
    Box user = await Hive.openBox(Constants.USER_BOX);
    AppFunction.prints(
        message: "++++++++++++++++=${email.value} and ${password.value}");
    Alerts.loading();
    _apiBasics
        .performRequest(
            requestType: RequestType.POST,
            url: Endpoints.LOGIN,
            postDta: {
              "email": email.value,
              "password": password.value.toString()
            },
            whenComplete: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, NavScreens.navScreens, (route) => false);
              Alerts.close();
            })
        .then((value) async {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(NavScreens.navScreens, (route) => false);
      setLoginResponse = value;
      user.put(Constants.TOKEN_KEY, value.data["token"]);
      Constants.setTokenSata = user.get(Constants.TOKEN_KEY);
      if (rememberMe.value == true) {
        user.put(Constants.CACHED_EMAIL_KEY, email.value);
        user.put(Constants.CACHED_PASSWORD_KEY, password.value);
      } else {
        user.put(Constants.CACHED_EMAIL_KEY, "");
        user.put(Constants.CACHED_PASSWORD_KEY, "");
      }
      setAppState = value.appState!;
    });

    return loginResponse;
  }
}
