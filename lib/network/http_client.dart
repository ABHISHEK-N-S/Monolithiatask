import 'package:data_list/network/endpoints.dart';
import 'package:data_list/network/exceptions.dart';
import 'package:dio/dio.dart';


enum RequestType { get, post, patch, delete }

abstract class HttpClient {
  Future<Response> request(EndPoint endPoint,
      {Map<String, dynamic>? params, Map<String, dynamic>? queryParameters, String? id});
}

class HttpClientImpl implements HttpClient {
  final Dio _dio;

  HttpClientImpl(this._dio) {
    _initApiClient();
  }

  void _initApiClient() {
    var dio = Dio(BaseOptions(
      connectTimeout: const Duration(milliseconds: 50000),
      receiveTimeout: const Duration(milliseconds: 100000),
      followRedirects: false,
      validateStatus: (status) {
        return status! < 500;
      },
      responseType: ResponseType.json,
    ));

    _dio.options = dio.options;
    _dio.interceptors.add(LogInterceptor(
      responseBody: true,
      error: true,
      requestBody: true,
      request: true,
      requestHeader: true,
    ));
  }

  @override
  Future<Response> request(EndPoint endPoint,
      {Map<String, dynamic>? params, Map<String, dynamic>? queryParameters, String? id}) async {
    // final authController = getx.Get.find<AuthBaseController>();

    // if (endPoint.shouldAddToken == true && authController.isAuthenticated) {
    //   _dio.options.headers = {'Authorization': 'Token ${authController.loginResponse.value?.access}'};
    // } else {
    //   _dio.options.headers = {};
    // }

    Response? response;
    String url;
    if (id != null) {
      url = endPoint.cleanUrlWith(id);
    } else {
      url = endPoint.url;
    }
    try {
      switch (endPoint.requestType) {
        case RequestType.get:
          response = await _dio.get(url, queryParameters: params ?? queryParameters);
          break;
        case RequestType.post:
          response = await _dio.post(url, data: FormData.fromMap(params!), queryParameters: queryParameters);
          break;
        case RequestType.patch:
          response = await _dio.patch(url, data: FormData.fromMap(params!), queryParameters: queryParameters);
          break;
        case RequestType.delete:
          response = await _dio.delete(url, data: FormData.fromMap(params!));
      }
    } on DioException catch (error) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:

        case DioExceptionType.sendTimeout:

        case DioExceptionType.receiveTimeout:
          throw FetchDataException('Timeout Error\n\n${error.message}');
        case DioExceptionType.badResponse:
          response = error.response; // If response is available.
          break;
        case DioExceptionType.cancel:
          throw FetchDataException('Request Cancelled\n\n${error.message}');
        case DioExceptionType.unknown:
          String message =
          error.message!.contains('SocketException') ? "No Internet Connection" : "Oops, Something went wrong";

          // error.message.contains('No Internet Connection') ? "asdasd" : "asdasda";
          throw FetchDataException('$message\n\n${error.message}');


        case DioExceptionType.badCertificate:
          // TODO: Handle this case.
          break;
        case DioExceptionType.connectionError:
          // TODO: Handle this case.
          break;
      }
    }

    return checkAndReturnResponse(response);
  }

  dynamic checkAndReturnResponse(Response? response) {
    String? description;

    // App specific handling!
    if (response?.data != null && response?.data is Map) {
      description = response?.data.containsKey('message')
          ? response?.data['message']
          : response?.data.containsKey('detail')
          ? response?.data['detail']
          : null;
    }

    switch (response?.statusCode) {
      case 200:
      case 201:
      // Null check for response.data
        if (response?.data == null) {
          throw FetchDataException('Returned response data is null : ${response?.statusMessage}');
        }

        return response;
      case 400:
        throw BadRequestException(description ?? response?.statusMessage);
      case 401:
        throw UnauthorisedException(description ?? response?.statusMessage);

      case 403:
        throw UnauthorisedException(description ?? response?.statusMessage);
      case 404:
        throw NotFoundException(description ?? response?.statusMessage);
      case 500:
        throw InternalServerException(description ?? response?.statusMessage);
      default:
        throw FetchDataException(
            "Unknown error occured\n\nerror Code: ${response?.statusCode}  error: ${description ?? response?.statusMessage}");
    }
  }
}
