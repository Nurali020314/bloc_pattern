
import 'package:bloc_pattern/bloc/update_post_cubit.dart';
import 'package:bloc_pattern/bloc/update_post_state.dart';
import 'package:bloc_pattern/service/log_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/post_model.dart';
import '../views/view_of_update.dart';

class UpdatePage extends StatefulWidget {
  Post? post;
  UpdatePage({Key? key,this.post}):super(key: key);

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {

  TextEditingController  titleController=TextEditingController();
  TextEditingController  bodyController=TextEditingController();

  _finish(BuildContext context){
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      Navigator.pop(context,"result");
    });
  }


  @override
  void initState() {
    super.initState();
    titleController.text=widget.post!.title.toString();
    bodyController.text=widget.post!.body.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Post"),
      ),
      body: BlocProvider(
        create: (context)=>UpdatePostCubit(),
        child:BlocBuilder<UpdatePostCubit,UpdatePostState>(
          builder: (BuildContext context,UpdatePostState state){
            if(state is UpdatePostLoading){
              LogService.e("1");
              String title=titleController.text.toString();
              String body=bodyController.text.toString();
              Post post=Post(
                id:widget.post!.id,
                title:title,
                body: body,
                userId: widget.post!.userId,
              );
             return viewOfUpdate(true, context,post,titleController,bodyController);
            }
            if(state is UpdatePostLoaded){
              LogService.e("2");
              _finish(context);
            }
            if(state is UpdatePostError){
              LogService.e("3");
            }
            return viewOfUpdate(false, context,widget.post!,titleController,bodyController);
          },
        ),
      ),
    );
  }
}
