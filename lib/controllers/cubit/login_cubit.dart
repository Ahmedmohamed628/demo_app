import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  void login(String name, String password) async {
    emit(LoginLoading());
    await Future.delayed(const Duration(seconds: 2));
    if (name == 'ahmed' && password == '123456789') {
      emit(LoginSuccess());
    } else {
      emit(LoginFailure('invalid name or password'));
    }
  }
}
