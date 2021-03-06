import 'package:flutter/material.dart';
import 'todo.dart';
import 'dropdown.dart';
class Dialogo extends StatefulWidget {
 
 
  @override
  _DialogoState createState() => _DialogoState();
}
class _DialogoState extends State<Dialogo> {
  
  final controllerTitle = new TextEditingController();
  final controllerBody = new TextEditingController();
    
   String _dropSelected = "DEFAULT";
    

   void se(value) => setState(() {
              _dropSelected = value;
              print(_dropSelected);
            });

 
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: <Widget>[
        FlatButton(onPressed:(){ var p=ToDo(name:controllerTitle.value.text, des: controllerBody.value.text,tipo: _dropSelected);
     controllerTitle.clear();
            controllerBody.clear();

            Navigator.of(context).pop(p);}, child: Text("Agregar")),
        FlatButton(onPressed: (){Navigator.of(context).pop(null);}, child: Text("Cancelar"))
      ],
    
      
      title: Text(
        'New todo',
        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20.0),
      ),
      content: Container( alignment: Alignment.center, width: 320, height: 200 ,child: Column(children: <Widget>[  TextField( decoration: InputDecoration(
        labelText: "Titulo",
       
      ), controller: controllerTitle,), Spacer(), TextField( decoration: InputDecoration(
        labelText: "Descripcion",
         ),controller: controllerBody,),
        Dropdown( se,_dropSelected )
         ])
      ));
      
      }
}
