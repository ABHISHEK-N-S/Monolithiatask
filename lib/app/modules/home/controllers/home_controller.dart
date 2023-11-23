import 'dart:convert';

import 'package:data_list/app/models/post_model.dart';
import 'package:data_list/network/endpoints.dart';
import 'package:data_list/network/exceptions.dart';
import 'package:data_list/network/http_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
class HomeController extends GetxController {
  //TODO: Implement HomeController
RxList<PostModel> postData = <PostModel>[].obs;
  final count = 0.obs;
  @override
  void onInit() {
    fetchPosts();
    super.onInit();
  }

  @override
  void onReady() {
    fetchPosts();
    super.onReady();
  }


  Future<void> fetchPosts() async {
    final Dio dio = Dio();

    // Step 2: Initialize HttpClientImpl with Dio instance
    final HttpClient httpClient = HttpClientImpl(dio);
    // final httpClients = Get.find<httpClient>();
    try {
      // EasyLoading.show();
      final response =  await httpClient.request(EndPoint.posts,

      );
      // final data = PostModel.fromJson(response.data);
      final responseData = response.data;
      if (responseData is List) {
        // Handle the case where responseData is a list
        // For example, you might want to iterate through the list or handle it accordingly
        List<PostModel> postList = responseData.map((item) => PostModel.fromJson(item)).toList();
        postData.value = postList;
        // Now, postList contains a list of PostModel objects
      } else if (responseData is Map<String, dynamic>) {
        // Handle the case where responseData is a map
        final data = PostModel.fromJson(responseData);
        // Now, 'data' contains a single PostModel object
      } else {
        // Handle other cases if necessary
        // This could include cases where responseData has unexpected types
      }


// if (kDebugMode) {
//   print(data);
// }
      EasyLoading.dismiss();
    } on AppException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      // EasyLoading.dismiss();

      return;
    }
  }
  Future<void> fetchDeletePosts({required int id}) async {
    try {

      final response = await http.delete(Uri.parse("https://jsonplaceholder.typicode.com/posts/$id"));
print(response.body);
      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        // Parse the response body
        final Map<String, dynamic> data = json.decode(response.body);

        // Use the data as needed
        print('API Response: $data');
      } else {
        // Handle errors or non-200 status codes
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network errors or exceptions
      print('Error: $error');
    }

  }



  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
