import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users_test/Bloc/users_bloc.dart';
import 'package:users_test/UI/Autentication/LoginPage.dart';

import '../Home/UsersListPage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    emailController.text = "";
    passwordController.text = "";
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width,
          maxHeight: MediaQuery.of(context).size.height * 1.2,
        ),
        child: SafeArea(
          child: Scaffold(
            body: BlocConsumer<UsersBloc, UsersState>(
              listener: (context, state) {
                if (state is RegisterSuccessful) {
                  var snackBar = SnackBar(
                    content: Text(
                        'Login Successful!\nToken: ${state.userToken}\nUser Id: ${state.userId}'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BlocProvider<UsersBloc>(
                          create: (context) => UsersBloc(),
                          child: UsersListPage(email: emailController.text))));
                }

                if (state is RegisterFailed) {
                  var snackBar = SnackBar(
                    content:
                        Text('Login Unsuccessful!\nError: ${state.message}'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BlocProvider<UsersBloc>(
                          create: (context) => UsersBloc(),
                          child: UsersListPage(email: emailController.text))));
                }
              },
              builder: (blocContext, state) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Image(
                          image: AssetImage(
                              'assets/images/users_portal_image.png'),
                          height: 200),
                      const Text(
                        "Users List Portal",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        obscureText: true,
                        controller: passwordController,
                        decoration: InputDecoration(
                          hintText: "Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<UsersBloc>(blocContext).add(
                              RegisterUser(emailController.text,
                                  passwordController.text));
                        },
                        child: const Text("Sign up"),
                      ),
                      const SizedBox(height: 10),
                      RichText(
                        text: TextSpan(
                          text: "Already have an account? Press ",
                          style: const TextStyle(color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Log in',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.of(blocContext).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BlocProvider<UsersBloc>(
                                                create: (context) =>
                                                    UsersBloc(),
                                                child: const LoginPage()))),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
