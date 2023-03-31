import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users_test/Bloc/users_bloc.dart';
import 'package:users_test/Model/Job.dart';

class UsersListPage extends StatefulWidget {
  const UsersListPage({super.key});

  @override
  _UsersListPageState createState() => _UsersListPageState();
}

class _UsersListPageState extends State<UsersListPage> {
  List<Job> jobItemList = [
    Job(name: "Item 1", job: "Job", id: "1", createdAt: ""),
    Job(name: "Item 2", job: "Job", id: "2", createdAt: ""),
    Job(name: "Item 3", job: "Job", id: "3", createdAt: ""),
  ];

  void _addEditJob(bool add, {Job? job}) {
    String _name = "";
    String _job = "";
    showDialog(
      context: context,
      builder: (context) {
        return BlocProvider.value(
          value: BlocProvider.of<UsersBloc>(context),
          child: AlertDialog(
            title: Text(add ? 'add User' : 'Edit User'),
            content: Column(
              children: [
                TextField(
                  onChanged: (value) {
                    setState(() {
                      _name = value;
                    });
                  },
                  decoration:
                      const InputDecoration(hintText: 'Enter name here'),
                ),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      _job = value;
                    });
                  },
                  decoration: const InputDecoration(hintText: 'Enter job here'),
                )
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('CANCEL'),
              ),
              TextButton(
                onPressed: () {
                  BlocProvider.of<UsersBloc>(context)
                      .add(CreateJob(_name, _job));
                  Navigator.of(context).pop();
                },
                child: const Text('SAVE'),
              ),
            ],
          ),
        );
      },
    ).then((value) {
      if (kDebugMode) {
        print('Entered text: $value');
      }
    });
  }

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
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("USER NAME") //todo add user name
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
        itemCount: jobItemList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(jobItemList[index].name!),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      // Edit button implementation
                      _addEditJob(false);
                    },
                    icon: const Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        // Remove item from list
                        jobItemList.removeAt(index);
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
            jobItemList
                .add(Job(name: "Item 1", job: "Job", id: "1", createdAt: ""));
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
