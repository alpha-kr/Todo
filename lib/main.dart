 

import 'package:flutter/material.dart';
import 'dialogo.dart';
import 'todo.dart';

typedef void CartChangedCallback(ToDo ToDo, bool inCart);

class ShoppingListItem extends StatelessWidget {
  ShoppingListItem({this.toDo, this.inCart, this.onCartChanged ,this.value} )
      : super(key: ObjectKey(ToDo));

  final ToDo toDo;
  final String value; 
  final bool inCart;
  final CartChangedCallback onCartChanged;

 
   Color _cardColor(BuildContext context) {
    

    return inCart ? Colors.grey : Colors.yellow[200];
  }
    Icon addIcon(String value){
        if (value=="DEFAULT") {
         return Icon(Icons.check, size: 72.0);

        }
        if (value=="HOME_WORK") {
          return Icon(Icons.contacts, size: 72.0);


        }
        if (value=="CALL") {
           return Icon(Icons.call, size: 72.0);
        }else{
          return Icon(Icons.dialpad, size: 72.0);
        }
         
        
    }

  TextStyle _getTextStyle(BuildContext context) {
    if (!inCart) return null;

    return TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(

      color: _cardColor(context), 
      child: ListTile(
      onTap: () {
        onCartChanged(toDo, inCart);
      },
      contentPadding: EdgeInsets.all(20),
      
      leading: addIcon(toDo.tipo),
      subtitle: Text(toDo.des),
      title: Text(toDo.name, style: _getTextStyle(context)),
    )
    );
  }
}

 class ShoppingList extends StatefulWidget {
 

  final List<ToDo> toDos=[ ];
   ShoppingList() ;

  
  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  Set<ToDo> _shoppingCart = Set<ToDo>();
  

  void _handleCartChanged(ToDo toDo, bool inCart) {
    setState(() {
      

      if (!inCart)
        _shoppingCart.add(toDo);
      else
        _shoppingCart.remove(toDo);
    });
  }

   _addTodo() async {
    final todo = await showDialog<ToDo>(
      context: context,
      builder: (BuildContext context) {
        return Dialogo();
      },
    );
    if (todo!=null) {
      setState(() {
         this.widget.toDos.add(todo);
      });
     
    }
   
    
    
    }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: _addTodo, child: Icon(Icons.add)
      ),
      appBar: AppBar(
        
        title: Text('App to do'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        children: widget.toDos.map((ToDo toDo) {
          return Dismissible( key: UniqueKey(),
          onDismissed: (direccion){
            setState(() {
               
              widget.toDos.remove(toDo);
            });
          },
           background: Container(
            padding: EdgeInsets.all(10.0),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Deleting',
                  style: TextStyle(color: Colors.white),
                )),
            color: Colors.red),
           child: ShoppingListItem(
            toDo: toDo,
            inCart: _shoppingCart.contains(toDo),
            onCartChanged: _handleCartChanged,
          ));
        }).toList(),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  @override
  _MyappState createState() => _MyappState();
}

class _MyappState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
       theme: ThemeData(
         primaryColor: Colors.purple,
         floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Colors.purple),
         buttonColor: Colors.purple,
       ),
    title: 'Shopping App',
    home: ShoppingList(
 
    ),
  );
  }
}