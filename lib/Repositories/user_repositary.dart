

import 'dart:convert';

import 'package:http/http.dart';

import '../Constants/constant.dart';

class UserRepository {
  Future<Response> getAllUsersOnPage(int id) async {
    var toReturn= get(
      Uri.parse('${Constant.BASE_URL}/api/users?page=$id'),
    );
    print("////////////////////////////////////");
    toReturn.then((value) => print(value.statusCode));
    toReturn.then((value) => print(value.body));
    toReturn.then((value) => print(value.statusCode));
    print("////////////////////////////////////");
    return toReturn;
  }

  Future<Response> getSingleUser(int id) async {
    var toReturn= get(
      Uri.parse('${Constant.BASE_URL}/api/users/$id'),
    );
    print("////////////////////////////////////");
    toReturn.then((value) => print(value.statusCode));
    toReturn.then((value) => print(value.body));
    toReturn.then((value) => print(value.statusCode));
    print("////////////////////////////////////");
    return toReturn;
  }

  Future<Response> getUsersWithoutPage() async {
    var toReturn= get(
      Uri.parse('${Constant.BASE_URL}/api/unknown'),
    );
    print("////////////////////////////////////");
    toReturn.then((value) => print(value.statusCode));
    toReturn.then((value) => print(value.body));
    toReturn.then((value) => print(value.statusCode));
    print("////////////////////////////////////");
    return toReturn;
  }

  Future<Response> getSingleUserWithoutPage(int id) async {
    var toReturn= get(
      Uri.parse('${Constant.BASE_URL}/api/unknown/$id'),
    );
    print("////////////////////////////////////");
    toReturn.then((value) => print(value.statusCode));
    toReturn.then((value) => print(value.body));
    toReturn.then((value) => print(value.statusCode));
    print("////////////////////////////////////");
    return toReturn;
  }

  Future<Response> createUser(String name, String job) async {
    var toReturn= post(
      Uri.parse('${Constant.BASE_URL}/api/users'),
      body: jsonEncode({
        "name": name,
        "job": job,
      }),
    );
    print("////////////////////////////////////");
    toReturn.then((value) => print(value.statusCode));
    toReturn.then((value) => print(value.body));
    toReturn.then((value) => print(value.statusCode));
    print("////////////////////////////////////");
    return toReturn;
  }

  Future<Response> updateUser(String name, String job, int id) async {
    var toReturn= post(
      Uri.parse('${Constant.BASE_URL}/api/users/$id'),
      body: jsonEncode({
        "name": name,
        "job": job,
      }),
    );
    print("////////////////////////////////////");
    toReturn.then((value) => print(value.statusCode));
    toReturn.then((value) => print(value.body));
    toReturn.then((value) => print(value.statusCode));
    print("////////////////////////////////////");
    return toReturn;
  }

  Future<Response> patchUser(String name, String job, int id) async {
    var toReturn= patch(
      Uri.parse('${Constant.BASE_URL}/api/users/$id'),
      body: jsonEncode({
        "name": name,
        "job": job,
      }),
    );
    print("////////////////////////////////////");
    toReturn.then((value) => print(value.statusCode));
    toReturn.then((value) => print(value.body));
    toReturn.then((value) => print(value.statusCode));
    print("////////////////////////////////////");
    return toReturn;
  }

  Future<Response> deleteUser(int id) async {
    var toReturn= delete(
      Uri.parse('${Constant.BASE_URL}/api/users/$id'),
    );
    print("////////////////////////////////////");
    toReturn.then((value) => print(value.statusCode));
    toReturn.then((value) => print(value.body));
    toReturn.then((value) => print(value.statusCode));
    print("////////////////////////////////////");
    return toReturn;
  }

  Future<Response> registerUser(String email, String password) async {
    var toReturn= post(
      Uri.parse('${Constant.BASE_URL}/api/register'),
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );
    print("////////////////////////////////////");
    toReturn.then((value) => print(value.statusCode));
    toReturn.then((value) => print(value.body));
    toReturn.then((value) => print(value.statusCode));
    print("////////////////////////////////////");
    return toReturn;
  }

  Future<Response> loginUser(String email, String password) async {
    var toReturn= post(
      Uri.parse('${Constant.BASE_URL}/api/register'),
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );
    print("////////////////////////////////////");
    toReturn.then((value) => print(value.statusCode));
    toReturn.then((value) => print(value.body));
    toReturn.then((value) => print(value.statusCode));
    print("////////////////////////////////////");
    return toReturn;
  }

  Future<Response> getDelayedUsers(int delay) async {
    var toReturn= get(
      Uri.parse('${Constant.BASE_URL}/api/users?delay=$delay'),
    );
    print("////////////////////////////////////");
    toReturn.then((value) => print(value.statusCode));
    toReturn.then((value) => print(value.body));
    toReturn.then((value) => print(value.statusCode));
    print("////////////////////////////////////");
    return toReturn;
  }
}