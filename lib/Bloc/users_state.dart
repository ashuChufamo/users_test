part of 'users_bloc.dart';

@immutable
abstract class UsersState {}

class UsersInitial extends UsersState {}

class UsersLoading extends UsersState {}

class UserFailed extends UsersState {
  final String message;

  UserFailed(this.message);
}

class UserSuccessful extends UsersState {
  final User user;

  UserSuccessful(this.user);
}

class UsersListOnPageSuccessful extends UsersState {
  final UsersInPage usersInPage;

  UsersListOnPageSuccessful(this.usersInPage);
}

class GetAllUnknownSuccessful extends UsersState {
  final UnKnown allUnknown;

  GetAllUnknownSuccessful(this.allUnknown);
}

class GetSingleUnknownSuccessful extends UsersState {
  final Data singleUnknown;

  GetSingleUnknownSuccessful(this.singleUnknown);
}

class UnknownFailed extends UsersState {
  final String message;

  UnknownFailed(this.message);
}

class UsersListOnPageWithDelaySuccessful extends UsersState {
  final UsersInPage usersInPage;

  UsersListOnPageWithDelaySuccessful(this.usersInPage);
}

class UsersListOnPageFailed extends UsersState {
  final String message;

  UsersListOnPageFailed(this.message);
}

class UsersListSuccessful extends UsersState {
  final List<User> users;

  UsersListSuccessful(this.users);
}

class RegisterSuccessful extends UsersState {
  final String userId;
  final String userToken;

  RegisterSuccessful(this.userId, this.userToken);
}

class LoginSuccessful extends UsersState {
  final String token;

  LoginSuccessful(this.token);
}

class CreateJobSuccessful extends UsersState {
  final Job job;

  CreateJobSuccessful(this.job);
}

class UpdateJobSuccessful extends UsersState {
  final Job job;

  UpdateJobSuccessful(this.job);
}

class PatchJobSuccessful extends UsersState {
  final Job job;

  PatchJobSuccessful(this.job);
}

class DeleteJobSuccessful extends UsersState {
  DeleteJobSuccessful();
}

class JobOpreationFailed extends UsersState {
  final String message;

  JobOpreationFailed(this.message);
}

class RegisterFailed extends UsersState {
  final String message;

  RegisterFailed(this.message);
}

class LoginFailed extends UsersState {
  final String message;

  LoginFailed(this.message);
}

class DelayedUsers extends UsersState {
  final List<User> users;

  DelayedUsers(this.users);
}
