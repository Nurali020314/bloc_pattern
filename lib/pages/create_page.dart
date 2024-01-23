
import 'package:bloc_pattern/bloc/create_post_cubit.dart';
import 'package:bloc_pattern/bloc/create_post_state.dart';
import 'package:bloc_pattern/service/log_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../views/view_of_create.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  TextEditingController  titleController=TextEditingController();
  TextEditingController  bodyController=TextEditingController();

  _finish(BuildContext context){
    LogService.e("cmdmc");
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      Navigator.pop(context,"result");
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Post"),
      ),
      body: BlocProvider(
        create: (context)=>CreatePostCubit(),
        child: BlocBuilder<CreatePostCubit,CreatePostState>(
          builder:(BuildContext context,CreatePostState state){
            if(state is CreatePostLoading){
              LogService.e("loading");
              return viewOfCreate(true,context,titleController,bodyController);
            }
            if(state is CreatePostLoaded){
              LogService.e("finish");
               _finish(context);
            }
            if(state is CreatePostError){
              LogService.e("error");
              //
            }
            return viewOfCreate(false,context,titleController,bodyController);
          } ,
        ),
      ),
    );
  }


}
