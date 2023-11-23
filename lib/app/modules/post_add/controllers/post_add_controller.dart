import 'package:data_list/network/endpoints.dart';
import 'package:data_list/network/exceptions.dart';
import 'package:data_list/network/http_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class PostAddController extends GetxController {
  //TODO: Implement PostAddController
TextEditingController title = TextEditingController();
TextEditingController body = TextEditingController();
  final count = 0.obs;
  @override
  void onInit() {

    super.onInit();
  }

  Future<void> fetchAddPosts({required String title, required String body,required int id}) async {
    final Dio dio = Dio();

    // Step 2: Initialize HttpClientImpl with Dio instance
    final HttpClient httpClient = HttpClientImpl(dio);
    // final httpClients = Get.find<httpClient>();
    try {
      // EasyLoading.show();
      print(title);
      final response =  await httpClient.request(EndPoint.addPost,params: {"title": title,  "body": body,
        "userId": id,}

      );
      print(response.data);


    } on AppException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      // EasyLoading.dismiss();

      return;
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
