import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: HomePage(),
    );
  }
}

class Item {
  String name;
  bool check;

  Item(this.name, this.check);
}

class HomePage extends StatefulWidget {
  var items = <Item>[];

  HomePage() {
    items = [];
    items.add(Item("Arroz", true));
    items.add(Item("Feijão", true));
    items.add(Item("Farinha", true));
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Text("OP"),
        title: Text("Home"),
        actions: <Widget>[
          Icon(Icons.local_grocery_store),
        ],
      ),
      body: ListView.builder(
          itemCount: widget.items.length,
          itemBuilder: (BuildContext context, int index) {
            final item = widget.items[index];
            return CheckboxListTile(
              title: Text(item.name),
              key: Key(item.name),
              value: item.check,
              onChanged: (value) {
                setState(() {
                  item.check = !item.check;
                });
              },
            );
          }),
    );
  }
}
