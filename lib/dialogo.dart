import 'package:flutter/material.dart';
import 'todo.dart';
 
class Dialogo extends StatefulWidget {
 
 
  @override
  _DialogoState createState() => _DialogoState();
}
class _DialogoState extends State<Dialogo> {
  
  final controllerTitle = new TextEditingController();
  final controllerBody = new TextEditingController();
 
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: <Widget>[
        FlatButton(onPressed:(){ var p=Product(name:controllerTitle.value.text, des: controllerBody.value.text);
     controllerTitle.clear();
            controllerBody.clear();

            Navigator.of(context).pop(p);}, child: Text("Agregar")),
        FlatButton(onPressed: null, child: Text("Cancelar"))
      ],
    
      
      title: Text(
        'New todo',
        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20.0),
      ),
      content: Container( alignment: Alignment.center, width: 200, height: 150 ,child: Column(children: <Widget>[  TextField( decoration: InputDecoration(
        labelText: "Titulo",
        border: OutlineInputBorder()
      ), controller: controllerTitle,), Spacer(), TextField( decoration: InputDecoration(
        labelText: "Descripcion",
        border: OutlineInputBorder()),controller: controllerBody,)
         ])
      ));
      
      }
}
