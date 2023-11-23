import 'package:data_list/app/models/post_detail_model.dart';
import 'package:data_list/network/endpoints.dart';
import 'package:data_list/network/exceptions.dart';
import 'package:data_list/network/http_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class PostDetailController extends GetxController {
  //TODO: Implement PostDetailController

  final count = 0.obs;
  late int postId;
  RxList<PostDetailModel> postDetail = <PostDetailModel>[].obs;
  @override
  void onInit() {
    // Retrieve the passed data using Get.arguments
    postId = Get.arguments as int;
    print(postId);
    // Now, you can use the postId in your controller logic
    fetchPostDetails(id: postId);
    super.onInit();
  }



  @override
  void onReady() {
    postId = Get.arguments as int;
    print(postId);
    // Now, you can use the postId in your controller logic
    fetchPostDetails(id: postId);
    super.onReady();
  }
  Future<void> fetchPostDetails({required int id}) async {
    final Dio dio = Dio();

    final HttpClient httpClient = HttpClientImpl(dio);

    try {
      // EasyLoading.show();
      final response =  await httpClient.request(EndPoint.comments,
          params: {"postId": id, }
      );
      // final data = PostModel.fromJson(response.data);
      final responseData = response.data;
      if (responseData is List) {
        // Handle the case where responseData is a list
        // For example, you might want to iterate through the list or handle it accordingly
        List<PostDetailModel> postList = responseData.map((item) => PostDetailModel.fromJson(item)).toList();
        // postData.value = postList;
        postDetail.value = postList;
        // Now, postList contains a list of PostModel objects

      } else if (responseData is Map<String, dynamic>) {
        // Handle the case where responseData is a map
        final data = PostDetailModel.fromJson(responseData);
        // Now, 'data' contains a single PostModel object
      } else {
        // Handle other cases if necessary
        // This could include cases where responseData has unexpected types
      }


// if (kDebugMode) {
//   print(data);
// }
//       EasyLoading.dismiss();
    } on AppException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      // EasyLoading.dismiss();

      return;
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
