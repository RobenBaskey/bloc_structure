import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../error/api_exception.dart';

abstract class RemoteDataSource {
  Future<dynamic> getRequest(
      {required String url, Map<String, dynamic>? body, bool? isToken});
  Future<dynamic> postRequest(
      {required String url,
        required Map<String, dynamic> body,
        bool? isNonEncodeData});
}

typedef CallClientMethod = Future<http.Response> Function();

class RemoteDataSourceImpl extends RemoteDataSource {
  final http.Client client = http.Client();
  final _className = 'RemoteDataSourceImpl';


  @override
  Future getRequest(
      {required String url, Map<String, dynamic>? body, bool? isToken}) async {
    Uri uri;
    Future<Response> clientMethod;

    if (body != null) {
      uri = Uri.parse(url).replace(queryParameters: body);
      if (isToken == true) {
        clientMethod = client.get(
          uri,
          headers: {"authorization": "Bearer "},
        );
      } else {
        clientMethod = client.get(uri);
      }
    } else {
      final uri = Uri.parse(url);
      if (isToken == true) {
        clientMethod = client.get(
          uri,
          headers: {"authorization": "Bearer "},
        );
      } else {
        clientMethod = client.get(uri);
      }
    }

    final responseJsonBody =
    await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["message"];
      throw UnauthorisedException(errorMsg, 410);
    } else {
      return responseJsonBody;
    }
  }

  @override
  Future postRequest(
      {required String url,
        required Map<String, dynamic> body,
        bool? isNonEncodeData,
        String? contentType}) async {
    final uri = Uri.parse(url);
    debugPrint("My Post url = $url");
    final clientMethod = client.post(
      uri,
      headers: {"Content-Type": contentType ?? "application/json"},
      body: isNonEncodeData == true ? json.encode(body) : body,
    );
    final responseJsonBody =
    await callClientWithCatchException(() => clientMethod);
    if (responseJsonBody["success"] == false) {
      final errorMsg = responseJsonBody["message"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      return responseJsonBody;
    }
  }

  Future<dynamic> callClientWithCatchException(
      CallClientMethod callClientMethod) async {
    try {
      final response = await callClientMethod();
      if (kDebugMode) {
        print("status code : ${response.statusCode}");
      }
      return _responseParser(response);
    } on SocketException {
      log('SocketException', name: _className);
      throw const NetworkException(
          'Please check your \nInternet Connection', 10061);
    } on http.ClientException {
      ///503 Service Unavailable
      log('http ClientException', name: _className);
      throw const NetworkException('Service unavailable', 503);
    } on FormatException {
      log('FormatException', name: _className);
      throw const DataFormatException('Data format exception', 422);
    } on InternalServerException {
      log('TimeoutException', name: _className);
      throw const InternalServerException('Request timeout', 500);
    } on TimeoutException {
      log('TimeoutException', name: _className);
      throw const NetworkException('Request timeout', 408);
    }
  }

  dynamic _responseParser(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);
        return responseJson;
      case 400:
        final errorMsg = parsingDoseNotExist(response.body);
        throw BadRequestException(errorMsg, 400);
      case 401:
        final errorMsg = parsingDoseNotExist(response.body);
        throw UnauthorisedException(errorMsg, 401);
      case 402:
        final errorMsg = parsingDoseNotExist(response.body);
        throw UnauthorisedException(errorMsg, 402);
      case 403:
        final errorMsg = parsingDoseNotExist(response.body);
        throw UnauthorisedException(errorMsg, 403);
      case 404:
        throw const UnauthorisedException('Request not found', 404);
      case 405:
        throw const UnauthorisedException('Method not allowed', 405);
      case 408:

      ///408 Request Timeout
        throw const NetworkException('Request timeout', 408);
      case 415:

      /// 415 Unsupported Media Type
        throw const DataFormatException('Data format exception');

      case 422:

      ///Unprocessable Entity
        final errorMsg = parsingError(response.body);
        throw InvalidInputException(errorMsg, 422);
      case 500:

      ///500 Internal Server Error
        throw const InternalServerException('Internal server error', 500);

      default:
        throw FetchDataException(
            'Error occurred while communication with Server',
            response.statusCode);
    }
  }

  String parsingError(String body) {
    final errorsMap = json.decode(body);
    try {
      if (errorsMap['errors'] != null) {
        final errors = errorsMap['errors'] as Map;
        final firstErrorMsg = errors.values.first;
        if (firstErrorMsg is List) return firstErrorMsg.first;
        return firstErrorMsg.toString();
      }
      if (errorsMap['message'] != null) {
        return errorsMap['message'];
      }
    } catch (e) {
      log(e.toString(), name: _className);
    }

    return 'Unknown error';
  }

  String parsingDoseNotExist(String body) {
    final errorsMap = json.decode(body);
    try {
      if (errorsMap['notification'] != null) {
        return errorsMap['notification'];
      }
      if (errorsMap['message'] != null) {
        return errorsMap['message'];
      }
    } catch (e) {
      log(e.toString(), name: _className);
    }
    return 'Credentials does not match';
  }
}