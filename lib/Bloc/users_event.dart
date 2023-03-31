part of 'users_bloc.dart';

@immutable
abstract class UsersEvent {}

class GetAllUsersOnPage extends UsersEvent {
  final int pageId;

  GetAllUsersOnPage(this.pageId);
}

class GetSingleUser extends UsersEvent {
  final int userId;

  GetSingleUser(this.userId);
}

class GetAllUnknown extends UsersEvent {}

class GetSingleUnKnown extends UsersEvent {
  final int userId;

  GetSingleUnKnown(this.userId);
}

class CreateJob extends UsersEvent {
  final String name;
  final String job;

  CreateJob(this.name, this.job);
}

class UpdateJob extends UsersEvent {
  final int userId;
  final String name;
  final String job;

  UpdateJob(this.userId, this.name, this.job);
}

class PatchJob extends UsersEvent {
  final int userId;
  final String name;
  final String job;

  PatchJob(this.userId, this.name, this.job);
}

class DeleteJob extends UsersEvent {
  final int userId;

  DeleteJob(this.userId);
}

class RegisterUser extends UsersEvent {
  final String email;
  final String password;

  RegisterUser(this.email, this.password);
}

class LoginUser extends UsersEvent {
  final String email;
  final String password;

  LoginUser(this.email, this.password);
}

class GetDelayedUser extends UsersEvent {
  final int delay;

  GetDelayedUser(this.delay);
}
