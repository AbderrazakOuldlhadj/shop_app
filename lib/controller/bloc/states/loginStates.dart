abstract class LoginState {}

class LoginInitState extends LoginState {}

class LoginLoadState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginErrorState extends LoginState {
  final String error;

  LoginErrorState(this.error);
}

class ChangePasswordVisibility extends LoginState {}
