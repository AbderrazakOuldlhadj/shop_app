import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:shop_app/controller/cashing/HiveKeys.dart';

class Api {
  final Dio api = Dio();
  static String apiUrl = "https://student.valuxapps.com/api/";

  Api() {
    api.options.baseUrl = apiUrl;
    api.options.receiveDataWhenStatusError = true;
    api.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = Hive.box('data').get(HiveKeys.token) ?? "";
          options.headers = {
            'lang' : 'en',
            'Content-Type': 'application/json',
            'Authorization' : token,
          };
          return handler.next(options);
        },
      ),
    );
  }
}
