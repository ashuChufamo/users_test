part of 'users_bloc.dart';

@immutable
abstract class UsersEvent {}

class GetAllUsersOnPage extends UsersEvent{
  final int pageId;
  GetAllUsersOnPage(this.pageId);
}

class GetSingleUser extends UsersEvent{
  final int userId;
  GetSingleUser(this.userId);
}

class GetUsersWithoutPage extends UsersEvent{

}

class GetSingleUserWithoutPage extends UsersEvent{
  final int userId;
  GetSingleUserWithoutPage(this.userId);
}

class CreateUser extends UsersEvent{}
class UpdateUser extends UsersEvent{}
class PatchUser extends UsersEvent{}
class DeleteUser extends UsersEvent{}
class RegisterUser extends UsersEvent{}
class LoginUser extends UsersEvent{}
class GetDelayedUser extends UsersEvent{}