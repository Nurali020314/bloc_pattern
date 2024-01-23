
import 'package:bloc_pattern/bloc/update_post_state.dart';
import 'package:bloc_pattern/model/post_model.dart';
import 'package:bloc_pattern/service/http_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdatePostCubit extends Cubit<UpdatePostState>{
  UpdatePostCubit():super(UpdatePostInit());

  void  apiPostUpdate(Post post) async{
    emit(UpdatePostLoading());
    final response=await Network.PUT(Network.API_UPDATE+post.id.toString(), Network.paramsUpdate(post));
    if(response!=null){
      emit(UpdatePostLoaded(isUpdated:true));
    }else{
      emit(UpdatePostError(error: "could not update post"));
    }
  }

}