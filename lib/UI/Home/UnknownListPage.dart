import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users_test/Bloc/users_bloc.dart';
import 'package:users_test/UI/Home/JobListPage.dart';
import '../../Model/Data.dart';
import 'UsersListPage.dart';

class UnknownListPage extends StatefulWidget {
  final String email;

  const UnknownListPage({super.key, required this.email});

  @override
  _UnknownListPageState createState() => _UnknownListPageState();
}

class _UnknownListPageState extends State<UnknownListPage> {
  List<Data> dataList = [];

  void initState() {
    super.initState();
    BlocProvider.of<UsersBloc>(context).add(GetAllUnknown());
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
              title: const Text('User CRUD'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => BlocProvider<UsersBloc>(
                        create: (context) => UsersBloc(),
                        child: UsersListPage(email: widget.email))));
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("Unknown List Page"),
      ),
      body: BlocConsumer<UsersBloc, UsersState>(
        listener: (context, state) {
          if (state is GetSingleUnknownSuccessful) {
            var snackBar = SnackBar(
              content: Text(
                  'Single User Get Successful!\nFirst Name: ${state.singleUnknown.name}'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            dataList.clear();
            dataList.add(state.singleUnknown);
          }
          if (state is GetAllUnknownSuccessful) {
            var snackBar = const SnackBar(
              content: Text('Users on specific page Get Successful!'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            dataList.clear();
            dataList = state.allUnknown.data!;
          }
          if (state is UnknownFailed) {
            var snackBar = const SnackBar(
              content: Text('Unknown Get Failed!'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            dataList.clear();
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
                    hintText: 'Enter the UnKnown Id',
                    hintStyle: const TextStyle(fontSize: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    filled: true,
                    contentPadding: const EdgeInsets.all(16),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<UsersBloc>(blocContext)
                      .add(GetSingleUnKnown(int.parse(searchController.text)));
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
                    : (state is GetAllUnknownSuccessful ||
                            state is GetSingleUnknownSuccessful)
                        ? ListView(
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height,
                                child: ListView.builder(
                                  itemCount: dataList.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      child: ListTile(
                                        leading: const CircleAvatar(
                                            backgroundColor: Color(0xFFbfeb91)),
                                        title: Text(dataList[index].name!),
                                        trailing:
                                            Text("${dataList[index].year!}"),
                                        subtitle:
                                            Text(dataList[index].pantoneValue!),
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
    );
  }
}
