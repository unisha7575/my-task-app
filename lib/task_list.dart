import 'package:flutter/material.dart';
import 'package:my_task_app/add_task.dart';

class TaskList extends StatefulWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List list = [];
  bool isClicked = false;
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Center(child: Text("Added  To Do List")),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: List.generate(
            list.length,
            (index) {
              return Card(
                color: Colors.blueGrey[100],
                child: ListTile(
                 leading: InkWell(onTap:(){
                   setState((){
                     isClicked =!isClicked;

                   });
                 },
                 child: Icon((isClicked)?Icons.check_box_outline_blank:Icons.check_box,color: Colors.blueGrey,size: 30,)),
                  title: Text("name : ${list[index]["name"]}",style: TextStyle(fontSize: 17,color: Colors.black),),
                  subtitle: Text("desc : ${list[index]["desc"]}",style: TextStyle(fontSize: 17,color: Colors.black),),
                   trailing:Row(
                     mainAxisSize: MainAxisSize.min,
                     children: [
                          InkWell(onTap:(){

                            setState(() {
                              isSelected  = !isSelected ;
                            });
                          },
                   child: Icon((isSelected )?Icons.star_outline:Icons.star,color: Colors.blueGrey,size: 30,)),
                       Icon(Icons.delete,color: Colors.blueGrey,size: 30,),


                     ],
                   )
                  //
                  //
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        onPressed: ()async {
      var data = await Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddTask()));
      setState(() {
        list .add(data);
      });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
