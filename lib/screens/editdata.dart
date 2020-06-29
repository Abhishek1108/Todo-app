import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/models/user.dart';
import 'package:todoapp/screens/mainscreen.dart';
import 'package:todoapp/utils/db.dart';
import 'package:todoapp/utils/convertdbtoTask.dart';

class editData extends StatefulWidget {
   user taskobj;
  editData(this.taskobj){
    this.taskobj=taskobj;
  }
  @override
  _editDataState createState() => _editDataState();
}

class _editDataState extends State<editData> {

 TextEditingController todo1 =TextEditingController();
  TextEditingController decr1=TextEditingController();
  _showDialog(){
    var media=MediaQuery.of(context).size;
    return AlertDialog(
      title: Text("Update Dialog",style: TextStyle(color: Colors.black,fontSize: 25),),
      elevation: 8,
      backgroundColor: Colors.red,
      content: Container(
        height: media.height/3,
        child: Column(
          children: <Widget>[
            Text("Record Updated Sucessflully",style:TextStyle(color: Colors.black,fontSize: 25),)
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Icon(Icons.clear,color: Colors.black,size: 25,),
            
            onPressed:(){
            Navigator.of(context).pop();
          
        }, )
      ],
    );
  }


    _update(docid){
     user us=new user(todo1.text,decr1.text);
     us.id=docid;
     Future<void> future =db.updateData(docid, us);
     future.then((ref){
       showDialog(context: context,builder:(context)=>_showDialog());
       convert.setTask(null);
     }).catchError((err){
       print("error is$err");

        });



  }
  void initState(){
      super.initState();
      todo1.text=widget.taskobj.todo;
      decr1.text=widget.taskobj.decr;

  }
  @override
  Widget build(BuildContext context) {
    var media =MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Update ToDo list"),
        leading: IconButton(
            icon:Icon(Icons.arrow_back,color: Colors.black,size: 30,), onPressed:(){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>mainscreen()));
        }),
      ),
      body: SafeArea(
        child: Container(
          child:Center(
            child: SingleChildScrollView(
              child: Container(

                height: media.height*.70,
                width: media.width*0.90,
                child: Card(
                  color:Colors.blueAccent,
                  elevation: 20,
                  child:Column(
                    children: <Widget>[
                      SizedBox(
                        height: 25,

                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("What to do!",style:TextStyle(fontSize:35,fontWeight: FontWeight.bold,color: Colors.white ),),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                        height: 60,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color:Colors.pink[100]
                        ),
                        //mainAxisAlignment: MainAxisAlignment.center,
                        child: TextField(
                          controller: todo1,
                          autocorrect: true,
                          // autofocus: true,

                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide:BorderSide(color: Colors.blueAccent),
                              ),

                              hintText:"what to do",
                              hintStyle:TextStyle(fontSize: 25,color: Colors.white),
                              prefixIcon: Icon(Icons.person,color: Colors.black,)
                          ),
                        ),

                      ),
                      SizedBox(
                        width: 20,
                        height: 60,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color:Colors.pink[100]
                        ),
                        //mainAxisAlignment: MainAxisAlignment.center,
                        child: TextField(
                          controller: decr1,
                          //  obscureText: true,
                          autocorrect: true,
                          //autofocus: true,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide:BorderSide(color: Colors.blueAccent),
                            ),

                            hintText:"description",
                            hintStyle:TextStyle(fontSize: 25,color: Colors.white),
                            // prefixIcon: Icon(Icons.lock,color: Colors.black,),
                            // suffixIcon: Icon(Icons.visibility_off,color: Colors.black,)
                          ),
                        ),

                      ),SizedBox(
                        width: 20,
                        height: 60,
                      ),
                      Container(

                        child: Center(
                          child: ButtonTheme(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),

                            minWidth:60,
                            height: 50,
                            buttonColor: Colors.pink[100],
                            child: RaisedButton(
                                elevation: 15,
                                child: Text("update",style: TextStyle(color: Colors.white,fontSize: 30),),
                                onPressed:(){
                                  _update(widget.taskobj.id);
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>mainscreen()));
                                }),
                          ),
                        ),
                      )

                    ],

                  ),

                ),
              ),
            ),
          ) ,

        ),

      ),
    );
  }
}

