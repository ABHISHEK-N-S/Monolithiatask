import 'package:get/get.dart';

import '../controllers/post_add_controller.dart';

class PostAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostAddController>(
      () => PostAddController(),
    );
  }
}
