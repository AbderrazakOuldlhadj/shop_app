import 'package:shop_app/model/LoginModel.dart';

abstract class LoginState {}

class LoginInitState extends LoginState {}

class LoginLoadState extends LoginState {}

class LoginSuccessState extends LoginState {
  final LoginModel loginModel;

  LoginSuccessState(this.loginModel);
}

class LoginErrorState extends LoginState {
  final String error;

  LoginErrorState(this.error);
}

class ChangePasswordVisibility extends LoginState {}

class LogoutLoadState extends LoginState {}

class LogoutSuccessState extends LoginState {}

class LogoutErrorState extends LoginState {
  final String error;

  LogoutErrorState(this.error);
}
