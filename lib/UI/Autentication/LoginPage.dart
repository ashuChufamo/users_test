import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users_test/Bloc/users_bloc.dart';
import 'package:users_test/UI/Autentication/SignupPage.dart';

import '../Home/UsersListPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
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
                if (state is LoginSuccessful) {
                  var snackBar = SnackBar(
                    content: Text('Login Successful!\nToken: ${state.token}'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BlocProvider<UsersBloc>(
                          create: (context) => UsersBloc(),
                          child: UsersListPage(email: emailController.text))));
                }

                if (state is LoginFailed) {
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
                          print(emailController.text);
                          print(passwordController.text);
                          BlocProvider.of<UsersBloc>(blocContext).add(LoginUser(
                              emailController.text, passwordController.text));
                        },
                        child: const Text("Login"),
                      ),
                      const SizedBox(height: 10),
                      RichText(
                        text: TextSpan(
                          text: "If you don't have account press ",
                          style: const TextStyle(color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Register',
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
                                                child: const SignUpPage()))),
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
