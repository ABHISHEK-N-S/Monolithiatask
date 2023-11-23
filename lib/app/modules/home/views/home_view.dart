import 'package:data_list/app/modules/post_detail/controllers/post_detail_controller.dart';
import 'package:data_list/app/modules/post_detail/views/post_detail_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: Icon(Icons.segment,color:Colors.cyanAccent),
        backgroundColor: Color(0xff0D3257),
        title: const Text('Monolithia blogs',
            style: TextStyle(color: Colors.cyanAccent)),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          child: Obx(() => ListView.builder(
            itemCount: controller.postData.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(

                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  tileColor: Colors.grey.shade100,

                  trailing: IconButton(onPressed: (){
                    controller.postData.removeAt(index);
                    print(controller.postData[index].id);
                    controller.fetchDeletePosts(id: controller.postData[index].id!);
                  },icon: Icon(Icons.delete),),
                  title: Text(controller.postData[index].title ?? "",style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(controller.postData[index].body ?? "",style: TextStyle(fontStyle: FontStyle.italic),),
                  onTap: () {


                    Get.to(() => const PostDetailView(),
                        arguments: controller.postData[index].id);


                  },
                ),
              );
            },
          )),
        ),
      ),
    );
  }
}
