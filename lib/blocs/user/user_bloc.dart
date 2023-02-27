import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodapp/repository/user_repository.dart';

import '../../models/users.dart';

part 'user_event.dart';
part 'user_state.dart';

final auth.FirebaseAuth firebaseAuth = auth.FirebaseAuth.instance;

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;
  UserBloc(this._userRepository) : super(UserLoading()) {
    on<GetUserEvent>(_onGetUser);
    on<UpdateUserEvent>(_onUpdateUser);
  }

  void _onGetUser(GetUserEvent event, Emitter<UserState> emit) {
    emit(UserLoading());
    try {
      var authUser = firebaseAuth.currentUser;
      if (authUser != null) {
        User user = _userRepository.getUser(authUser.uid);

        emit(UserLoaded(user));
      }
    } catch (e) {
      emit(UserEror(e.toString()));
    }
  }

  void _onUpdateUser(UpdateUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      await _userRepository.updateUser(event.user).whenComplete(
          () => emit(UserLoaded(firebaseAuth.currentUser as User)));
    } catch (e) {
      emit(UserEror(e.toString()));
    }
  }
}
