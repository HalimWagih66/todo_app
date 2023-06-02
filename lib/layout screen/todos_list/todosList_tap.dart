import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/database/models/task.dart';
import 'package:todo_app/database/my_database.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/auth_provider.dart';
import 'TaskItem.dart';
class TodosList_Tap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var authProvider= Provider.of<AuthProvider>(context);
    return Column(
      children: [
        Expanded(
          child: StreamBuilder<QuerySnapshot<Task>>(
            stream: MyDataBase.readTasks(authProvider.currentUser?.id??""),
            builder: (buildContext,snapshot){
              if(snapshot.hasError){
                return Center(child: Text(snapshot.toString()),);
              }
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(),);
              }
              var listTasks = snapshot.data?.docs.map((e) => e.data()).toList();
              if(listTasks?.isEmpty == true){
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.menu,size: 100,color: Color(0xA67A7A7A),),
                      SizedBox(height: 10,),
                      Text("You don't have any Tasks Yet",style: TextStyle(color: Color(0xA67A7A7A))),
                    ],
                  ));
              }
              return ListView.builder(itemBuilder: (context,index){
                return TaskItem(listTasks![index]);
              },itemCount: listTasks?.length ??0);
            }
            ),
        ),
      ],
    );
  }
}
