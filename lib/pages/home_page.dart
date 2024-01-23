import 'package:bloc_pattern/bloc/list_post_cubit.dart';
import 'package:bloc_pattern/bloc/list_post_state.dart';
import 'package:bloc_pattern/pages/create_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/post_model.dart';
import '../views/item_of_post.dart';

class HomePageAA extends StatefulWidget {
  const HomePageAA({super.key});

  @override
  State<HomePageAA> createState() => _HomePageAAState();
}

class _HomePageAAState extends State<HomePageAA> {

  List<Post> items=[];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ListPostCubit>(context).apiPostList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("BloC"),
        ),
        body: BlocBuilder<ListPostCubit, ListPostState>(
          builder: (BuildContext context, ListPostState state) {
            if (state is ListPostError) {
              return viewOfError(state.error);
            }
            if (state is ListPostLoaded) {
              var items = state.posts;
              return viewOfHome(items!,false);
            }
            return viewOfHome(items,true);
          },
        ),
       floatingActionButton: FloatingActionButton(
         backgroundColor: Colors.blue,
         foregroundColor: Colors.white,
         onPressed: (){
           BlocProvider.of<ListPostCubit>(context).callCreatePage(context);
         },
         child: const Icon(Icons.add),
       ),
    );
  }

  Widget viewOfError(String error){
    return Center(
      child: Text("Error occurred $error"),
    );
  }

  Widget viewOfHome(List<Post> items,bool isLoading,){
     return Stack(
       children: [
         ListView.builder(
           itemCount: items.length,
             itemBuilder: (ctx,index){
             return itemHomePost(ctx,items[index]);
             }),
           isLoading ? const Center(
             child: CircularProgressIndicator(),
           ):SizedBox.shrink(),
       ],
     );
  }

}
