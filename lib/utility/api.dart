import 'dart:convert';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:ultimate_demo/components/show_dialog.dart';
import 'package:ultimate_demo/utility/generatedKey.dart';
import 'package:flutter/foundation.dart';
import 'package:ultimate_demo/utility/constants.dart';

class Api {
  Future<Map> getData(String url, {bool ignoreGeneratedKey = false}) async {
    //await Future.delayed(Duration(seconds: 3));
    dynamic _response = "";
    Map mapToReturn = Map();
    try {
      Dio httpClient = Dio();
      if (kDebugMode) {
        if (httpClient.httpClientAdapter.runtimeType ==
            DefaultHttpClientAdapter)
          (httpClient.httpClientAdapter as DefaultHttpClientAdapter)
              .onHttpClientCreate = (HttpClient client) {
            client.badCertificateCallback =
                (X509Certificate cert, String host, int port) => true;
            return client;
          };
      }
      //final ioc = new HttpClient();
      // if (kDebugMode) {
      //   ioc.badCertificateCallback =
      //       (X509Certificate cert, String host, int port) => true;
      // }
      //final http = new IOClient(ioc);
      //await Future.delayed(Duration(seconds: 1));
      Response response = await httpClient.get<String>('$apiUrl' + '/$url',
          options: Options(headers: {
            'gk': (ignoreGeneratedKey ? '' : await getGeneratedKey()),
            'authorization': ('bearer ' +
                (StaticVariables.accessToken != null
                    ? StaticVariables.accessToken.accessToken
                    : ""))
          }));
      if (response.statusCode == 200) {
        mapToReturn['success'] = true;
        _response = jsonDecode(response.toString());
        mapToReturn['data'] = _response;
      }
      // else if (response.headers.containsKey('errormessage')) {
      //   Codec<String, String> stringToBase64 = utf8.fuse(base64);
      //   String d = stringToBase64.decode(response.headers['errormessage']);
      //   showErrorMessage(d);
      //   mapToReturn['success'] = false;
      //   mapToReturn['error'] = d;
      // }
      else {
        mapToReturn['success'] = false;
        _response = response.toString();
        mapToReturn['error'] = _response;
      }
    } catch (e) {
      print(e);
      mapToReturn['success'] = false;
      String errorToShow = e.toString();
      if (e.runtimeType == DioError) {
        errorToShow = e.error;
        //network error
        if ((e as DioError).response != null &&
            (e as DioError).response.headers.value('errormessage') != null) {
          Codec<String, String> stringToBase64 = utf8.fuse(base64);
          errorToShow = stringToBase64
              .decode(((e as DioError).response.headers.value('errormessage')));
        }
      }
      mapToReturn['error'] = errorToShow;
      showErrorMessage(errorToShow);
    }
    return mapToReturn;
  }

  Future<Map> postData(String url,
      {dynamic body = '', Map<String, String> header}) async {
    Map mapToReturn = Map();
    try {
      // print(url);
      // final ioc = new HttpClient();
      // if (kDebugMode) {
      //   ioc.badCertificateCallback =
      //       (X509Certificate cert, String host, int port) => true;
      // }
      final httpClient = new Dio();
      if (kDebugMode) {
        if (httpClient.httpClientAdapter.runtimeType ==
            DefaultHttpClientAdapter)
          (httpClient.httpClientAdapter as DefaultHttpClientAdapter)
              .onHttpClientCreate = (HttpClient client) {
            client.badCertificateCallback =
                (X509Certificate cert, String host, int port) => true;
            return client;
          };
      }
      if (header == null) header = Map<String, String>();
      dynamic _response = "";

      Response response = await httpClient.post<String>('$apiUrl' + '/$url',
          data: body,
          options: Options(headers: {
            'gk': await getGeneratedKey(),
            'authorization': ('bearer ' +
                (StaticVariables.accessToken != null
                    ? StaticVariables.accessToken.accessToken
                    : "")),
          }));
      if (response.statusCode == 200) {
        mapToReturn['success'] = true;
        _response = jsonDecode(response.toString());
        mapToReturn['data'] = _response;
      }
      // else if (response.headers.containsKey('errormessage')) {
      //   Codec<String, String> stringToBase64 = utf8.fuse(base64);
      //   String d = stringToBase64.decode(response.headers['errormessage']);
      //   showErrorMessage(d);
      //   mapToReturn['success'] = false;
      //   mapToReturn['error'] = d;
      // }
      else {
        mapToReturn['success'] = false;
        _response = response.toString();
        mapToReturn['error'] = _response;
        showErrorMessage(_response);
      }
    } catch (e) {
      print(e);
      mapToReturn['success'] = false;
      String errorToShow = e.toString();
      if (e.runtimeType == DioError) {
        errorToShow = e.error;
        //network error
        if ((e as DioError).response.headers.value('errormessage') != null) {
          Codec<String, String> stringToBase64 = utf8.fuse(base64);
          errorToShow = stringToBase64
              .decode(((e as DioError).response.headers.value('errormessage')));
        }
      }
      mapToReturn['error'] = errorToShow;
      showErrorMessage(errorToShow);
    }
    return mapToReturn;
  }
}
