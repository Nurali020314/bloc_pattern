import 'package:bloc_pattern/bloc/create_post_state.dart';
import 'package:bloc_pattern/model/post_model.dart';
import 'package:bloc_pattern/service/http_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CreatePostCubit extends Cubit<CreatePostState> {
  CreatePostCubit() : super(CreatePostInit());

  void apiPostCreate(Post post) async {
    emit(CreatePostLoading());
    final responce =
        await Network.POST(Network.API_CREAT, Network.paramsCreate(post));
    if (responce != null) {
      emit(CreatePostLoaded(isCreated: true));
    } else {
      emit(CreatePostError(error: "Could not create post"));
    }
  }

}
