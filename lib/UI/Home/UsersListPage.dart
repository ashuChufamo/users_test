import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users_test/Bloc/users_bloc.dart';
import 'package:users_test/UI/Home/JobListPage.dart';
import 'package:users_test/UI/Home/UnknownListPage.dart';
import '../../Model/User.dart';

class UsersListPage extends StatefulWidget {
  final String email;

  const UsersListPage({super.key, required this.email});

  @override
  _UsersListPageState createState() => _UsersListPageState();
}

class _UsersListPageState extends State<UsersListPage> {
  List<User> userItemList = [];

  void initState() {
    super.initState();
    BlocProvider.of<UsersBloc>(context).add(GetAllUsersOnPage(2));
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState>? _scaffoldKey;
    TextEditingController searchController = TextEditingController();
    return Scaffold(
      key: _scaffoldKey,
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
              title: const Text('Job CRUD'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => BlocProvider<UsersBloc>(
                        create: (context) => UsersBloc(),
                        child: JobListPage(email: widget.email))));
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
        title: const Text("Users List Page"),
      ),
      body: BlocConsumer<UsersBloc, UsersState>(
        listener: (context, state) {
          if (state is UserSuccessful) {
            var snackBar = SnackBar(
              content: Text(
                  'Single User Get Successful!\nFirst Name: ${state.user.firstName}'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            userItemList.clear();
            userItemList.add(state.user);
          }
          if (state is UsersListOnPageSuccessful) {
            var snackBar = const SnackBar(
              content: Text('Users on specific page Get Successful!'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            userItemList.clear();
            userItemList = state.usersInPage.usersList!;
          }
          if (state is UsersListOnPageWithDelaySuccessful) {
            var snackBar = const SnackBar(
              content:
                  Text('Users on specific page Get With Delay Successful!'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            userItemList.clear();
            userItemList = state.usersInPage.usersList!;
          }
        },
        builder: (blocContext, state) {
          return ListView(
            children: [
              SizedBox(
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: searchController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Enter the Users Id',
                    hintStyle: const TextStyle(fontSize: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    filled: true,
                    contentPadding: EdgeInsets.all(16),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<UsersBloc>(blocContext)
                      .add(GetSingleUser(int.parse(searchController.text)));
                },
                child: const Text("Search"),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                child: (state is UsersLoading)
                    ? Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(
                              Theme.of(context).primaryColor),
                        ),
                      )
                    : (state is UsersListSuccessful ||
                            state is UsersListOnPageSuccessful ||
                            state is UsersListOnPageWithDelaySuccessful ||
                            state is UserSuccessful)
                        ? ListView(
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height,
                                child: ListView.builder(
                                  itemCount: userItemList.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      child: ListTile(
                                        leading: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                userItemList[index].avatar!)),
                                        title: Text(
                                            "${userItemList[index].firstName!} ${userItemList[index].lastName!}"),
                                        subtitle:
                                            Text(userItemList[index].email!),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          )
                        : Container(),
              ),
            ],
          );
        },
      ),
      floatingActionButton: BlocBuilder<UsersBloc, UsersState>(
        builder: (blocContext, state) {
          return FloatingActionButton(
            onPressed: () {
              // Add item to list
              setState(() {
                BlocProvider.of<UsersBloc>(blocContext).add(GetDelayedUser(5));
              });
            },
            child: const Icon(Icons.restart_alt_sharp),
          );
        },
      ),
    );
  }
}
