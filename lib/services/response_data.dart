import 'package:kooha/helpers/alerts.dart';
import 'package:kooha/utils/application_state.dart';
import 'package:flutter/material.dart';

class ResponseData {
  String? responseMessage;
  dynamic data;
  ApplicationState? appState;
  bool showSuccess = true;
  VoidCallback? whenComplete;
  ResponseData(
      {required this.appState,
      required this.responseMessage,
      required this.data,
      this.whenComplete});
  ResponseData.fromJson({required Map<String, dynamic> json}) {
    whenComplete = json["whenComplete"];
    appState = json['appState'];
    responseMessage = json["responseMessage"];
    showSuccess = json["showSuccess"] ?? showSuccess;
    data = json["data"];
    Future.delayed(const Duration(seconds: 2), () {
      if (appState == ApplicationState.SUCCESS && showSuccess == true) {
        Alerts.showAlert(
            text: responseMessage ?? "Successful!",
            alertType: AlertType.SUCCESS);
        whenComplete!();
      } else if (appState == ApplicationState.FAILED) {
        Alerts.showAlert(
            text: responseMessage ?? "Request failed!",
            alertType: AlertType.FAILED);
      }
    });
    Alerts.close();
  }
}
