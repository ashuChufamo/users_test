import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../Repositories/user_repositary.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UserRepository userRepository;
  UsersBloc(userRepository) : userRepository = UserRepository(), super(UsersInitial()) {
    on<UsersEvent>((event, emit) {
      if (event is GetActivities) {
        yield ActivityLoading();
        Response res;
        try {
          res = await _userRepositary.getActivities();
          if (res.statusCode == 200) {
            yield ActivitySuccessful(List<Post>.from(
                jsonDecode(res.body)["feeds"].map((x) => Post.fromJson(x))));
          } else
            yield ActivityFailed();
        } catch (e) {
          yield ActivityFailed();
        }
      }
    });
  }
}
