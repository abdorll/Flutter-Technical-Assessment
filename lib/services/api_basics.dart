import 'package:kooha/helpers/alerts.dart';
import 'package:kooha/services/request_type.dart';
import 'package:kooha/services/response_data.dart';
import 'package:kooha/utils/application_state.dart';
import 'package:kooha/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiBasics {
  Dio? _dio;

  ResponseData? _responseData;
  Map<String, dynamic>? requestHeader;
  set setResponseData(data) {
    _responseData = data;
  }

  get getResponseData => _responseData!;
  ApiBasics() {
    requestHeader = header();
    _dio = Dio(BaseOptions(
        receiveTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),
        headers: {
          "Authorization": "Bearer ${Constants.getTokenData}",
        }));
    _dio!.interceptors.add(PrettyDioLogger(
      requestHeader: false,
      responseHeader: false,
    ));
  }
  Future<ResponseData> performRequest({
    required RequestType requestType,
    required String url,
    VoidCallback? whenComplete,
    String token = '',
    bool showSuccess = true,
    Map<String, String>? postDta,
  }) async {
    try {
      if (requestType == RequestType.GET) {
        Alerts.loading();
        await _dio!
            .get(
          url,
          options: Options(responseType: ResponseType.json),
        )
            .then((response) {
          setResponseData = ResponseData.fromJson(json: {
            "data": response.data["data"],
            "appState": (response.data.containsKey("data"))
                ? ApplicationState.SUCCESS
                : ApplicationState.FAILED,
            "showSuccess": showSuccess,
            "responseMessage":
                ((response.statusCode! >= 200 || response.statusCode! < 204) &&
                        response.data["status"] == true)
                    ? response.data["data"]["message"]
                    : "Successful!",
            "whenComplete": whenComplete ?? () {}
          });
        });
      } else if (requestType == RequestType.POST) {
        await _dio!
            .post(url,
                data: FormData.fromMap(postDta!),
                options: Options(responseType: ResponseType.json))
            .then((response) {
          setResponseData = ResponseData.fromJson(json: {
            "data": response.data["data"] as Map<String, dynamic>,
            "appState": response.data["status"] == true
                ? ApplicationState.SUCCESS
                : ApplicationState.FAILED,
            "responseMessage":
                ((response.statusCode! >= 200 || response.statusCode! < 204) &&
                        response.data["status"] == true)
                    ? response.data["data"]["message"]
                    : response.data["message"],
            "whenComplete": whenComplete ?? () {}
          });
        });
      }
    } on DioException catch (e) {
      setResponseData = ResponseData.fromJson(json: {
        "appState": ApplicationState.FAILED,
        "data": null,
        "responseMessage": e.message == null
            ? "Internet connection error!"
            : e.response != null
                ? e.response!.data["message"]
                : e.message
      });
    } catch (e) {
      setResponseData = ResponseData.fromJson(json: {
        "data": null,
        "appState": ApplicationState.FAILED,
        "responseMessage": e.toString()
      });
    }
    return getResponseData;
  }
}

// ======== COOK TOKEN ========
Map<String, String> header() {
  String token = "";
  Future<String> getHeader() async {
    var box = await Hive.openBox(Constants.USER_BOX);
    return box.get(Constants.TOKEN_KEY).toString();
  }

//======== INVOKE COOKED TOKEN ==
  getHeader().then((value) {
    token = value;
  });
  return {"Authorization": "Bearer $token", 'Content-Type': 'application/json'};
}
