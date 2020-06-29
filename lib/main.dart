import 'package:flutter/material.dart';
import 'package:todoapp/screens/adddatascreen.dart';
import 'package:todoapp/screens/mainscreen.dart';


void main(){
  runApp(MaterialApp(

 title: "Todo App",
 debugShowCheckedModeBanner: false,
 home:mainscreen() ,

  )
  );
}