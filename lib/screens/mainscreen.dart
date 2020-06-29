
import 'package:flutter/material.dart';
import 'package:todoapp/models/user.dart';
import 'package:todoapp/screens/adddatascreen.dart';
import 'package:todoapp/screens/editdata.dart';
import 'package:todoapp/utils/db.dart';
import 'package:todoapp/utils/convertdbtoTask.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class mainscreen extends StatefulWidget {
  @override
  _mainscreenState createState() => _mainscreenState();
}

class _mainscreenState extends State<mainscreen> {
  edit(id){
    List<user> tasklist=convert.getTask();
    user taskobj=tasklist.where((task)=> task.id==id ).toList()[0];
    Navigator.push(context, MaterialPageRoute(builder: (context)=>editData(taskobj)));

  }

  markRecord(id){
    List<user> tasklist=convert.getTask();
    for(int i=0;i<tasklist.length;i++){
      if(tasklist[i].id==id){
        tasklist[i].isMarked=!tasklist[i].isMarked;
      }
    }

  }
  _deleteRecords(){
    List<user> tasklist=convert.getTask();
    List<user> sublist=tasklist.where((task) => task.isMarked).toList();
    List<String > allids=sublist.map((task) => task.id).toList();
    db.deleteData(allids);
    convert.setTask(null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever,size: 25,color: Colors.black,),
            onPressed: (){
              _deleteRecords();
            },
          )
        ],
        title:Text( "Todo List"),
        centerTitle: true,

      ),
      body: FutureBuilder(
        future: convert.convertDbToTask(),
        builder: (BuildContext context, AsyncSnapshot<List<user>> snapshot) {
          if(!snapshot.hasData){
            return Center(
              child: Text("what to do add some to do"),
            );
          }
          else{

            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder:(context,index){

                  return Container(

                    color:snapshot.data[index].isMarked?Colors.red:Colors.white,


                   child:ListTile(
                     title: Text(snapshot.data[index].todo),
                     subtitle: Text(snapshot.data[index].decr),
                     trailing: Container(
                       width: 100,



                  child: Row(

                    children: <Widget>[
                     // Text(snapshot.data[index].todo),
                      IconButton(
                        icon: Icon(Icons.delete,size: 25,color: Colors.black,),
                        onPressed: (){
                          var currentid= snapshot.data[index].id;
                          markRecord(currentid);

                        },
                      ),
                      IconButton(
                        icon:Icon(Icons.edit,color: Colors.black,size:25),
                        onPressed: (){
                          edit(snapshot.data[index].id);
                         // Navigator.push(context, MaterialPageRoute(builder: (context)=>editData(snapshot.data[index].id)));
                        },
                      )
                    ],

                  ),
                     ),
                  ),
                  );
                });
          }
        },

      ),
      floatingActionButton:FloatingActionButton(
        child: Icon(Icons.add),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        elevation: 10,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>addDataScreen()));
        },
      ),
    );
  }
}
