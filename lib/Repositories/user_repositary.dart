import 'dart:convert';

import 'package:http/http.dart';

import '../Constants/constant.dart';

class UserRepository {
  Future<Response> getAllUsersOnPage(int id) async {
    return get(
      Uri.parse('${Constant.BASE_URL}/api/users?page=$id'),
    );
  }

  Future<Response> getSingleUser(int id) async {
    return get(
      Uri.parse('${Constant.BASE_URL}/api/users/$id'),
    );
  }

  Future<Response> getUsersWithoutPage() async {
    return get(
      Uri.parse('${Constant.BASE_URL}/api/unknown'),
    );
  }

  Future<Response> getSingleUserWithoutPage(int id) async {
    return get(
      Uri.parse('${Constant.BASE_URL}/api/unknown/$id'),
    );
  }

  Future<Response> createJob(String name, String job) async {
    return post(
      Uri.parse('${Constant.BASE_URL}/api/users'),
      body: jsonEncode({
        "name": name,
        "job": job,
      }),
    );
  }

  Future<Response> updateJob(String name, String job, int id) async {
    return put(
      Uri.parse('${Constant.BASE_URL}/api/users/$id'),
      body: jsonEncode({
        "name": name,
        "job": job,
      }),
    );
  }

  Future<Response> patchJob(String name, String job, int id) async {
    return patch(
      Uri.parse('${Constant.BASE_URL}/api/users/$id'),
      body: jsonEncode({
        "name": name,
        "job": job,
      }),
    );
  }

  Future<Response> deleteJob(int id) async {
    return delete(
      Uri.parse('${Constant.BASE_URL}/api/users/$id'),
    );
  }

  Future<Response> registerUser(String email, String password) async {
    return post(
      Uri.parse('${Constant.BASE_URL}/api/register'),
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );
  }

  Future<Response> loginUser(String email, String password) async {
    return post(
      Uri.parse('${Constant.BASE_URL}/api/login'),
      body: '{"email":"jviviv","password":"uvuvubu"}',
    );
  }

  Future<Response> getDelayedUsers(int delay) async {
    return get(
      Uri.parse('${Constant.BASE_URL}/api/users?delay=$delay'),
    );
  }
}
