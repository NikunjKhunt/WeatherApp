import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:weatherapp/utils/constants.dart';
import 'package:weatherapp/utils/shared_pref.dart';

class ApiWrapper {
  static Dio dio = Dio(
    BaseOptions(baseUrl: Cons.baseURL, connectTimeout: 10000, receiveTimeout: 10000, contentType: Headers.jsonContentType),
  );
  static String TAG = 'ApiWrapper';

  Future<dynamic> doRequest(String endpoint, Map<String, dynamic> params,
      {bool isAuthRequired = true, bool isFormData = false, String? callingMethod, String? passportToken, bool isCache = false}) async {
    Response? response;
    try {
      Options options;
      if (isCache && (callingMethod == null || callingMethod == "GET")) {
        //IF METHOD IS GET AND IS_CACHE IS ENABLED
        options = buildCacheOptions(const Duration(days: 1),
            options: Options(
              followRedirects: false,
              validateStatus: (status) {
                return true;
              },
              headers: await getHeaders("", isAuthRequired: isAuthRequired, passportToken: passportToken),
            ));
      } else {
        //FOR ALL OTHER METHODS
        options = Options(
          method: callingMethod,
          followRedirects: false,
          validateStatus: (status) {
            return (status! < 500);
          },
          headers: await getHeaders("", isAuthRequired: isAuthRequired, passportToken: passportToken),
          contentType: Headers.formUrlEncodedContentType,
        );
      }

      if ((callingMethod == null || callingMethod == "GET")) {
        //AS GET WILL PASS PARAMS AS QUERY PARAMS
        response = await dio.request(
          endpoint,
          queryParameters: params,
          options: options,
        );
      } else {
        response = await dio.request(
          endpoint,
          data: isFormData ? FormData.fromMap(params) : params,
          options: options,
        );
      }

      switch (response.statusCode) {
        case 200: // Result OK
        case 201: // Result OK
          break;

        case 400: // Bad Request
          break;
        case 401: // Unauthorized
        case 403: // Forbidden
        case 404: // Not Found
          // TODO Force Logout
          break;
        default:
          //TODO show error message from response
          break;
      }
      return response.data;
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
      } else if (e.type == DioErrorType.receiveTimeout) {
        return Future.value(null);
      } else if (e.type == DioErrorType.sendTimeout) {
      } else if (e.type == DioErrorType.other) {
        return Future.value(null);
      } else {
        return Future.value(null);
      }
    }
  }

  Future<Map<String, dynamic>?> doPost(String endpoint, Map<String, dynamic> params, bool isAuthRequired, {String? passportToken}) async {
    return await doRequest(endpoint, params, isAuthRequired: isAuthRequired, callingMethod: "POST", passportToken: passportToken);
  }

  Future<dynamic> doGet(String endpoint, Map<String, dynamic> params, {bool isCache = false}) async {
    return await doRequest(endpoint, params, isAuthRequired: true, isCache: isCache);
  }

  Future<Map<String, dynamic>?> doPut(String endpoint, Map<String, dynamic> params, {bool isCache = false}) async {
    return await doRequest(endpoint, params, callingMethod: "PUT", isAuthRequired: true, isCache: isCache);
  }

  Future<Map<String, dynamic>> getHeaders(
    String uniqueKey, {
    bool? isAuthRequired,
    String? passportToken,
  }) async {
    Map<String, dynamic> headers = {
      "Content-Type": 'application/json',
      "Accept": 'application/json',
      "Device-Identifier": uniqueKey,
    };
    if (isAuthRequired != null && isAuthRequired) {
      headers["Authorization"] = (passportToken != null && passportToken.isNotEmpty) ? passportToken : "Bearer ${await SharedPref.getAccessToken()}";
    }
    return headers;
  }
}
