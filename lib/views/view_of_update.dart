import 'package:bloc_pattern/bloc/update_post_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/post_model.dart';

Widget viewOfUpdate(
  bool isLoading,
  BuildContext context,
  Post post,
  TextEditingController titleController,
  TextEditingController bodyController
) {
  return Container(
    padding: EdgeInsets.all(30),
    child: Stack(
      children: [
        Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                  hintText: "Title", hintStyle:TextStyle(color: Colors.grey)
              ),
            ),
            const SizedBox(height: 10,),
            TextField(
              controller: bodyController,
              decoration: const InputDecoration(
                  hintText: "Body", hintStyle:TextStyle(color: Colors.grey)
              ),
            ),
            const SizedBox(height: 10,),
            MaterialButton(
                color: Colors.blue,
                child: const Text("Update  a Post",style: TextStyle(color: Colors.white),),
                onPressed: (){
                  post.title=titleController.text.trim();
                  post.body=bodyController.text.toString().trim();
                  BlocProvider.of<UpdatePostCubit>(context).apiPostUpdate(post);
                })
          ],
        ),
        isLoading? const Center(
          child: CircularProgressIndicator(),
        ):SizedBox.shrink()
      ],
    ),
  );
}
