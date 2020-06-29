import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/screens/mainscreen.dart';
import 'package:todoapp/models/user.dart';
import 'package:todoapp/utils/db.dart';

class addDataScreen extends StatefulWidget {
  @override
  _addDataScreenState createState() => _addDataScreenState();
}

class _addDataScreenState extends State<addDataScreen> {
  TextEditingController todo=TextEditingController();
  TextEditingController decr=TextEditingController();
  _addDataToDataBase(){
    user us=new user(todo.text,decr.text);
     Future<DocumentReference> firestore=db.addTodo(us);
  }
  @override
  Widget build(BuildContext context) {
    var media =MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
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
                          controller: todo,
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
                         controller: decr,
                         // obscureText: true,
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
                                child: Text("add",style: TextStyle(color: Colors.white,fontSize: 30),),
                                onPressed:(){

                               _addDataToDataBase();
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
