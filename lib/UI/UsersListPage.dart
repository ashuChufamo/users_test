import 'package:flutter/material.dart';

class Item {
  String name;
  Item(this.name);
}

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<Item> itemList = [
    Item("Item 1"),
    Item("Item 2"),
    Item("Item 3"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 40,
                    child: Image.asset(
                      'assets/images/user_profile.png',
                    ),
                  ),
                  const SizedBox(height: 20,),
                  const Text("USER NAME")//todo add user name
                ],
              ),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("Users List Page"),
      ),
      body: ListView.builder(
        itemCount: itemList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(itemList[index].name),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      // Edit button implementation
                    },
                    icon: const Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        // Remove item from list
                        itemList.removeAt(index);
                      });
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add item to list
          setState(() {
            itemList.add(Item("New Item"));
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}