import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart' as dio_;
import 'package:http/http.dart';
import 'package:vimeo_clone/config/security.dart';

class ApiException implements Exception {
  ApiException(this.errorMessage);

  final String errorMessage;

  @override
  String toString() {
    return errorMessage;
  }
}

class ApiBaseHelper {
  //To download the attachment, using the dio
  Future<void> downloadFile(
      {required String url,
        required dio_.CancelToken cancelToken,
        required String savePath,
        required Function updateDownloadedPercentage}) async {
    try {
      final dio_.Dio dio = dio_.Dio();
      await dio.download(url, savePath, cancelToken: cancelToken,
          onReceiveProgress: ((count, total) {
            updateDownloadedPercentage((count / total) * 100);
          }));
    } on dio_.DioException catch (e) {
      if (e.type == dio_.DioExceptionType.connectionError) {
        throw ApiException('No Internet connection');
      }

      throw ApiException('Failed to download file');
    } catch (e) {
      throw Exception('Failed to download file');
    }
  }



  // POST METHOD
  Future<dynamic> postAPICall(String url, dynamic params) async {
    var responseJson;
    // var timeOut = 10;
    final dio_.Dio dio = dio_.Dio();
    print('#@###########   ${params}');
    print('%%%%%%%%%%%%%%      ${headers}');
    print('faihfiahihihif    ${url}');
    try {
      print('ekjfnjesngjkng');
      final response =
      await dio.post(
          url,
          // queryParameters: params,
          data: params.isNotEmpty ? params : [],
          options: dio_.Options(
            headers: headers,
          ),
      );
      print('anfiaenfinffnf');
      // .timeout(Duration(seconds: timeOut));
      // log('+++ HEADERS  ${headers}');
      if (kDebugMode) {
        print(
            'response api****$url***************${response.statusCode}*********${response.data}');
      }

      // responseJson = _response(response);
      responseJson = response;
    } on SocketException {
      throw ApiException('No Internet connection');
    } on TimeoutException {
      throw ApiException('Something went wrong, Server not Responding');
    } on Exception catch (e) {
      // print('------Error  ${e}');
      throw ApiException('Something Went wrong with ${e.toString()}');
    }
    return responseJson;
  }


  Future<dynamic> loginUserEmail(String url, dynamic params) async {
    var responseJson;
    // var timeOut = 10;
    final dio_.Dio dio = dio_.Dio();
    print('#@###########   ${params}');
    // print('%%%%%%%%%%%%%%      ${headers}');
    try {

      final response =
      await dio.post(
        url,
        // queryParameters: params,
        data: params.isNotEmpty ? params : [],
        // options: dio_.Options(
        //   headers: headers,
        // ),
      );
      // .timeout(Duration(seconds: timeOut));
      // log('+++ HEADERS  ${headers}');
      if (kDebugMode) {
        log(
            'response api****$url***************${response.statusCode}*********${response.data['data']['token']}');
      }

      // responseJson = _response(response);
      responseJson = response;
    } on SocketException {
      throw ApiException('No Internet connection');
    } on TimeoutException {
      throw ApiException('Something went wrong, Server not Responding');
    } on Exception catch (e) {
      // print('------Error  ${e}');
      throw ApiException('Something Went wrong with ${e.toString()}');
    }
    return responseJson;
  }

  // FIREBASE LOGIN [*  Access token will be allocated to user when the user is logged in successfully *]

  Future<dynamic> firebaseLoginPostAPICall(String url, dynamic params, String token) async {
    var responseJson;
    // var timeOut = 10;
    final dio_.Dio dio = dio_.Dio();
    try {
      print('#@###########   ${params}');
      // print('%%%%%%%%%%%%%%      ${headers}');
      print('faihfiahihihif    ${url}');
      final response =
      await dio.post(
        url,
        data: params.isNotEmpty ? params : [],
        options: dio_.Options(
          headers: {
            'Content-Type':'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          },
        ),
      );
      // .timeout(Duration(seconds: timeOut));

      if (kDebugMode) {
        log(
            'response api****$url***************${response.statusCode}*********${response.data}');
      }

      // responseJson = _response(response);
      responseJson = response;
    } on SocketException {
      throw ApiException('No Internet connection');
    } on TimeoutException {
      throw ApiException('Something went wrong, Server not Responding');
    } on Exception catch (e) {
      // print('------Error  ${e}');
      throw ApiException('Something Went wrong with ${e.toString()}');
    }
    return responseJson;
  }





  // REGISTER NEW USER [* Token is allocated to user when the user is successfully created *]

  Future<dynamic> registerUserPostAPICall(String url, dynamic params) async {
    var responseJson;
    // var timeOut = 10;
    final dio_.Dio dio = dio_.Dio();
    print('----------------------------------');
    print('&&&&&&&7     ${params}');
    try {
      final response =
      await dio.post(
        url,
        data: params,
        options: dio_.Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          }
        )
      );

      if (kDebugMode) {
        log(
            'response api****$url***************${response.statusCode}*********${response.data['access_token']}');
      }

      // responseJson = _response(response);
      responseJson = response;
    } on SocketException {
      throw ApiException('No Internet connection');
    } on TimeoutException {
      throw ApiException('Something went wrong, Server not Responding');
    } on Exception catch (e) {
      // print('------Error  ${e}');
      throw ApiException('Something Went wrong with ${e.toString()}');
    }
    return responseJson;
  }


  // PUT METHOD
  Future<dynamic> putAPICall(String url, dynamic params) async {
    var responseJson;
    final dio_.Dio dio = dio_.Dio();
    print('#@###########   ${params}');
    print('%%%%%%%%%%%%%%      ${headers}');
    print('faihfiahihihif    ${url}');
    try {
      final response = await dio.put(
        url,
        data: params.isNotEmpty ? params : [],
        options: dio_.Options(
          headers: headers,
        ),
      );
      log('+++ HEADERS  ${headers}');
      if (kDebugMode) {
        print(
            'response api****$url***************${response.statusCode}*********${response.data}');
      }

      responseJson = response;
    } on SocketException {
      throw ApiException('No Internet connection');
    } on TimeoutException {
      throw ApiException('Something went wrong, Server not Responding');
    } on Exception catch (e) {
      throw ApiException('Something Went wrong with ${e.toString()}');
    }
    return responseJson;
  }



  Future<dynamic> forgotPasswordAPICall(String url, dynamic params) async {
    var responseJson;
    // var timeOut = 10;
    final dio_.Dio dio = dio_.Dio();
    print('#@###########   ${params}');
    // print('%%%print%%%%%%%%%%%      ${headers}');
    print('faihfiahihihif    ${url}');
    try {
      final response =
      await dio.post(
        url,
        // queryParameters: params,
        data: params.isNotEmpty ? params : [],
        options: dio_.Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (kDebugMode) {
        print(
            'response api****$url***************${response.statusCode}*********${response.data}');
      }

      // responseJson = _response(response);
      responseJson = response;
    } on SocketException {
      throw ApiException('No Internet connection');
    } on TimeoutException {
      throw ApiException('Something went wrong, Server not Responding');
    } on Exception catch (e) {
      // print('------Error  ${e}');
      throw ApiException('Something Went wrong with ${e.toString()}');
    }
    return responseJson;
  }



  Future<dynamic> getAPICall(String url, dynamic params) async {
    var responseJson;
    final dio_.Dio dio = dio_.Dio();
    try {
      final response =
      await dio.get(
          url,
          data: params.isNotEmpty ? params : [],
          options: dio_.Options(headers: headers)
      );
      if (kDebugMode) {
        print(
            'response api****$url*****************${response.statusCode}*********${response.data}');
      }

      responseJson = response;
    } on SocketException {
      throw ApiException('No Internet connection');
    } on TimeoutException {
      throw ApiException('Something went wrong, Server not Responding');
    } on Exception catch (e) {
      print('////////${e}///////');
      // throw ApiException('Something Went wrong with ${e.toString()}');
    }
    return responseJson;
  }


  Future<dynamic> deleteAPICall(String url, dynamic params) async {
    var responseJson;
    // var timeOut = 10;
    final dio_.Dio dio = dio_.Dio();
    print('#@###########   ${params}');
    print('%%%%%%%%%%%%%%      ${headers}');
    print('faihfiahihihif    ${url}');
    try {
      final response =
      await dio.delete(
        url,
        // queryParameters: params,
        data: params.isNotEmpty ? params : [],
        options: dio_.Options(
          headers: headers,
        ),
      );
      // .timeout(Duration(seconds: timeOut));
      log('+++ HEADERS  ${headers}');
      if (kDebugMode) {
        log(
            'response api****$url***************${response.statusCode}*********${response.data}');
      }

      // responseJson = _response(response);
      responseJson = response;
    } on SocketException {
      throw ApiException('No Internet connection');
    } on TimeoutException {
      throw ApiException('Something went wrong, Server not Responding');
    } on Exception catch (e) {
      // print('------Error  ${e}');
      throw ApiException('Something Went wrong with ${e.toString()}');
    }
    return responseJson;
  }


  dynamic _response(Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode: ${response.statusCode}');
    }
  }
}

class CustomException implements Exception {
  final message;
  final prefix;

  CustomException([this.message, this.prefix]);

  @override
  String toString() {
    return "$prefix$message";
  }
}

class FetchDataException extends CustomException {
  FetchDataException([message])
      : super(message, 'Error During Communication: ');
}

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(message, 'Invalid Request: ');
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([message]) : super(message, 'Unauthorised: ');
}

class InvalidInputException extends CustomException {
  InvalidInputException([message]) : super(message, 'Invalid Input: ');
}
