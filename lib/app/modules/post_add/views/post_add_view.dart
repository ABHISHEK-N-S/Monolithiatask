import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/post_add_controller.dart';

class PostAddView extends GetView<PostAddController> {
  final int? id;
  const PostAddView( {Key? key,this.id,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(()=>PostAddController());
    return Scaffold(

      appBar: AppBar(
        title: const Text('Monolithia Test'
        ,style: TextStyle(color: Colors.cyanAccent)),
        backgroundColor: Color(0xff0D3257),
        centerTitle: true,
      ),
      body:  Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            // key: ,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
              TextFormField(
                controller: controller.title,
                decoration: InputDecoration(
                  labelText: 'Blog Title',
                  hintText: 'Enter your Blog title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  contentPadding: EdgeInsets.all(16.0),

                ),
              ),
              const SizedBox(height: 20,),
 TextFormField(
                controller: controller.body,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Blog',
                  hintText: 'Enter your blogs here',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  contentPadding: EdgeInsets.all(16.0),

                ),
              )
              ,
                const SizedBox(height: 20,),
              MaterialButton(

                color: Colors.blueAccent,
                onPressed: ()async{


              await  controller.fetchAddPosts(title: controller.title.text,body: controller.body.text,id: id!);
Get.back();
              },child: Text("Save"),),
            ],),
          ),
        )


      ),
    );
  }
}
