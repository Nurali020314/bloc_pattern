
import 'package:bloc_pattern/bloc/list_post_state.dart';
import 'package:bloc_pattern/model/post_model.dart';
import 'package:bloc_pattern/pages/update_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../pages/create_page.dart';
import '../service/http_service.dart';

class ListPostCubit extends Cubit<ListPostState>{
  ListPostCubit():super(ListPostInit());

  void apiPostList() async{
    emit(ListPostLoading());
    final response=await Network.GET(Network.API_LIST, Network.paramsEmpty());
    if(response !=null){
       emit(ListPostLoaded(posts: Network.parsePostList(response)));
    }else{
      emit(ListPostError(error: "Could not fetch posts"));
    }
  }

  void apiPostDelate(Post post){
    emit(ListPostLoading());
    final response= Network.DELATE(Network.API_DELATE+post.id.toString(), Network.paramsEmpty());
    if(response !=null){
      apiPostList();
    }else{
      emit(ListPostError(error: "Could not delete posts"));
    }
  }

  void callCreatePage(BuildContext context) async {
    var results=await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context)=>CreatePage()));
    if(results !=null){
      BlocProvider.of<ListPostCubit>(context).apiPostList();
    }
  }

  void callUpdatePage(BuildContext context,Post post) async {
    var results=await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context)=>UpdatePage(post: post)));
    if(results !=null){
      BlocProvider.of<ListPostCubit>(context).apiPostList();
    }
  }

}
