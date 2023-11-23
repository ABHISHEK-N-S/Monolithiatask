import 'package:data_list/app/modules/post_add/views/post_add_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/post_detail_controller.dart';

class PostDetailView extends GetView<PostDetailController> {
  const PostDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(()=>PostDetailController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0D3257),
        title: const Text('Blog DetailView',style: TextStyle(color: Colors.cyanAccent)),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){

        var arg = Get.arguments;
        Get.to(()=> PostAddView(id: arg,));
      },child: const Text("Add",style: TextStyle(color: Colors.cyanAccent)),
        backgroundColor: Color(0xff0D3257),),
      body:  Container(
        child: Obx(() => ListView.builder(
          itemCount: controller.postDetail.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(

                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                tileColor: Colors.grey.shade100,


                title: Text(controller.postDetail[index].name ?? ""),
                subtitle: Text(controller.postDetail[index].email ?? ""),

              ),
            );
          },
        )),
      ),
    );
  }
}
