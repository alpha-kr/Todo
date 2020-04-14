 

import 'package:flutter/material.dart';
import 'dialogo.dart';
import 'todo.dart';

typedef void CartChangedCallback(Product product, bool inCart);

class ShoppingListItem extends StatelessWidget {
  ShoppingListItem({this.product, this.inCart, this.onCartChanged})
      : super(key: ObjectKey(product));

  final Product product;
  final bool inCart;
  final CartChangedCallback onCartChanged;

  Color _getColor(BuildContext context) {
    

    return inCart ? Colors.black54 : Theme.of(context).primaryColor;
  }
   Color _cardColor(BuildContext context) {
    

    return inCart ? Colors.grey : Colors.yellow[200];
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
        onCartChanged(product, inCart);
      },
      contentPadding: EdgeInsets.all(20),
      
      leading: CircleAvatar(
        backgroundColor: _getColor(context),
        child: Text(product.name[0]),
      ),
      subtitle: Text(product.des),
      title: Text(product.name, style: _getTextStyle(context)),
    )
    );
  }
}

 class ShoppingList extends StatefulWidget {
 

  final List<Product> products=[ ];
   ShoppingList() ;

  
  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  Set<Product> _shoppingCart = Set<Product>();
  

  void _handleCartChanged(Product product, bool inCart) {
    setState(() {
      

      if (!inCart)
        _shoppingCart.add(product);
      else
        _shoppingCart.remove(product);
    });
  }

   _addTodo() async {
    final todo = await showDialog<Product>(
      context: context,
      builder: (BuildContext context) {
        return Dialogo();
      },
    );
    if (todo!=null) {
      setState(() {
         this.widget.products.add(todo);
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
        children: widget.products.map((Product product) {
          return Dismissible( key: UniqueKey(),
          onDismissed: (direccion){
            setState(() {
               
              widget.products.remove(product);
            });
          },
          
           child: ShoppingListItem(
            product: product,
            inCart: _shoppingCart.contains(product),
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