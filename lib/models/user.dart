class user{
  String id;
  String todo;
  String decr;
  bool isMarked =false;
  bool isAdded=false;
  bool isEdit=false;
  user(this.todo,this.decr);
  convertToMap(){
    Map<String,dynamic> map={
      "todo":this.todo,
    "decr":this.decr,
    };
    return map;
  }
}
 class editDataToFirebase{
  String todo1;
  String decr1;
  editDataToFirebase(this.todo1,this.decr1);
  convertMap(){
    Map<String, dynamic> tap={
      "todo":this.todo1,
      "decr":this.decr1,
    };
    return tap;
  }


}