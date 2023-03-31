import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:users_test/Model/Job.dart';
import 'package:users_test/Model/Unknown.dart';
import 'package:users_test/Model/User.dart';
import '../Model/Data.dart';
import '../Model/UsersWithPage.dart';
import '../Repositories/user_repositary.dart';

part 'users_event.dart';

part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UserRepository userRepository;

  UsersBloc()
      : userRepository = UserRepository(),
        super(UsersInitial()) {
    on<UsersEvent>((event, emit) async {
      if (event is GetAllUsersOnPage) {
        emit(UsersLoading());
        Response res;
        try {
          res = await userRepository.getAllUsersOnPage(event.pageId);
          if (res.statusCode == 200) {
            emit(UsersListOnPageSuccessful(
                UsersInPage.fromJson(jsonDecode(res.body))));
          } else {
            emit(UsersListOnPageFailed(res.body));
          }
        } catch (e) {
          emit(UsersListOnPageFailed(e.toString()));
        }
      }

      if (event is GetSingleUser) {
        emit(UsersLoading());
        Response res;
        try {
          res = await userRepository.getSingleUser(event.userId);
          if (res.statusCode == 200) {
            emit(UserSuccessful(User.fromJson(jsonDecode(res.body)['data'])));
          } else {
            emit(UserFailed(res.body));
          }
        } catch (e) {
          emit(UserFailed(e.toString()));
        }
      }

      if (event is GetAllUnknown) {
        emit(UsersLoading());
        Response res;
        try {
          res = await userRepository.getUsersWithoutPage();
          if (res.statusCode == 200) {
            emit(GetAllUnknownSuccessful(
                UnKnown.fromJson(jsonDecode(res.body))));
          } else {
            emit(UnknownFailed(res.body));
          }
        } catch (e) {
          emit(UnknownFailed(e.toString()));
        }
      }

      if (event is GetSingleUnKnown) {
        emit(UsersLoading());
        Response res;
        try {
          res = await userRepository.getSingleUserWithoutPage(event.userId);
          if (res.statusCode == 200) {
            emit(GetSingleUnknownSuccessful(
                Data.fromJson(jsonDecode(res.body)['data'])));
          } else {
            emit(UnknownFailed(res.body));
          }
        } catch (e) {
          emit(UnknownFailed(e.toString()));
        }
      }

      if (event is CreateJob) {
        emit(UsersLoading());
        Response res;
        try {
          res = await userRepository.createJob(event.name, event.job);
          if (res.statusCode == 201) {
            emit(CreateJobSuccessful(Job.fromJson(jsonDecode(res.body))));
          } else {
            emit(JobOpreationFailed(res.body));
          }
        } catch (e) {
          emit(JobOpreationFailed(e.toString()));
        }
      }

      if (event is UpdateJob) {
        emit(UsersLoading());
        Response res;
        try {
          res = await userRepository.updateJob(
              event.name, event.job, event.userId);
          if (res.statusCode == 200) {
            emit(UpdateJobSuccessful(Job.fromJson(jsonDecode(res.body))));
          } else {
            emit(JobOpreationFailed(res.body));
          }
        } catch (e) {
          emit(JobOpreationFailed(e.toString()));
        }
      }

      if (event is PatchJob) {
        emit(UsersLoading());
        Response res;
        try {
          res = await userRepository.patchJob(
              event.name, event.job, event.userId);
          if (res.statusCode == 200) {
            emit(PatchJobSuccessful(Job.fromJson(jsonDecode(res.body))));
          } else {
            emit(JobOpreationFailed(res.body));
          }
        } catch (e) {
          emit(JobOpreationFailed(e.toString()));
        }
      }

      if (event is DeleteJob) {
        emit(UsersLoading());
        Response res;
        try {
          res = await userRepository.deleteJob(event.userId);
          if (res.statusCode == 204) {
            emit(DeleteJobSuccessful());
          } else {
            emit(JobOpreationFailed(res.body));
          }
        } catch (e) {
          emit(JobOpreationFailed(e.toString()));
        }
      }

      if (event is RegisterUser) {
        emit(UsersLoading());
        Response res;
        try {
          res = await userRepository.registerUser(event.email, event.password);
          if (res.statusCode == 201) {
            emit(RegisterSuccessful(
                jsonDecode(res.body)["id"], jsonDecode(res.body)["token"]));
          } else {
            emit(RegisterFailed(res.body));
          }
        } catch (e) {
          emit(RegisterFailed(e.toString()));
        }
      }

      if (event is LoginUser) {
        emit(UsersLoading());
        Response res;
        try {
          res = await userRepository.loginUser(event.email, event.password);
          if (res.statusCode == 200) {
            emit(LoginSuccessful(jsonDecode(res.body)["token"]));
          } else {
            emit(LoginFailed(res.body));
          }
        } catch (e) {
          emit(LoginFailed(e.toString()));
        }
      }

      if (event is GetDelayedUser) {
        emit(UsersLoading());
        Response res;
        try {
          res = await userRepository.getDelayedUsers(event.delay);
          if (res.statusCode == 200) {
            emit(UsersListOnPageWithDelaySuccessful(
                UsersInPage.fromJson(jsonDecode(res.body))));
          } else {
            emit(UsersListOnPageFailed(res.body));
          }
        } catch (e) {
          emit(UsersListOnPageFailed(e.toString()));
        }
      }
    });
  }
}
