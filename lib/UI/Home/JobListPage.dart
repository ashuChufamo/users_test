import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users_test/Bloc/users_bloc.dart';
import 'package:users_test/Model/Job.dart';

import 'UnknownListPage.dart';
import 'UsersListPage.dart';

class JobListPage extends StatefulWidget {
  final String email;

  const JobListPage({super.key, required this.email});

  @override
  _JobListPageState createState() => _JobListPageState();
}

class _JobListPageState extends State<JobListPage> {
  List<Job> jobItemList = [
    Job(name: "Job 1", job: "Job", id: "1", createdAt: ""),
    Job(name: "Job 2", job: "Job", id: "2", createdAt: ""),
    Job(name: "Job 3", job: "Job", id: "3", createdAt: ""),
  ];

  void _addEditJob(bool add, BuildContext myContext, {Job? myJob}) {
    TextEditingController nameController = TextEditingController();
    TextEditingController jobController = TextEditingController();

    if (myJob != null) {
      nameController.text = myJob.name!;
      jobController.text = myJob.job!;
    }
    showDialog(
      context: context,
      builder: (context) {
        return BlocProvider.value(
          value: BlocProvider.of<UsersBloc>(myContext),
          child: AlertDialog(
            title: Text(add ? 'add User' : 'Edit User'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration:
                      const InputDecoration(hintText: 'Enter name here'),
                ),
                TextField(
                  controller: jobController,
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
                  add
                      ? BlocProvider.of<UsersBloc>(myContext).add(
                          CreateJob(nameController.text, jobController.text))
                      : BlocProvider.of<UsersBloc>(myContext).add(UpdateJob(
                          int.parse(myJob!.id!),
                          nameController.text,
                          jobController.text,
                        ));
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
    GlobalKey<ScaffoldState>? scaffoldKey;
    return Scaffold(
      key: scaffoldKey,
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
                  Text(widget.email),
                ],
              ),
            ),
            ListTile(
              title: const Text('User CRUD'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => BlocProvider<UsersBloc>(
                        create: (context) => UsersBloc(),
                        child: UsersListPage(email: widget.email))));
              },
            ),
            ListTile(
              title: const Text('Unknown CRUD'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => BlocProvider<UsersBloc>(
                        create: (context) => UsersBloc(),
                        child: UnknownListPage(email: widget.email))));
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("Job List Page"),
      ),
      body: BlocConsumer<UsersBloc, UsersState>(
        listener: (context, state) {
          if (state is UpdateJobSuccessful) {
            var snackBar = SnackBar(
              content: Text(
                  'Job Update Successful!\nUpdated at: ${state.job.createdAt}'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          if (state is PatchJobSuccessful) {
            var snackBar = SnackBar(
              content: Text(
                  'Job Patch Successful!\nUpdated at: ${state.job.createdAt}'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          if (state is CreateJobSuccessful) {
            var snackBar = SnackBar(
              content: Text(
                  'Job Update Successful!\nCreated at: ${state.job.createdAt}'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          if (state is DeleteJobSuccessful) {
            const snackBar = SnackBar(
              content: Text('Job Delete Successful!'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          if (state is JobOpreationFailed) {
            var snackBar = SnackBar(
              content: Text('Job Operation Failure! \nError: ${state.message}'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        builder: (blocContext, state) {
          return ListView.builder(
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
                          _addEditJob(false, blocContext,
                              myJob: jobItemList[index]);
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            BlocProvider.of<UsersBloc>(context).add(
                                DeleteJob(int.parse(jobItemList[index].id!)));
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
          );
        },
      ),
      floatingActionButton: BlocBuilder<UsersBloc, UsersState>(
        builder: (blocContext, state) {
          return FloatingActionButton(
            onPressed: () {
              // Add item to list
              setState(() {
                _addEditJob(true, blocContext);
              });
            },
            child: const Icon(Icons.add),
          );
        },
      ),
    );
  }
}
