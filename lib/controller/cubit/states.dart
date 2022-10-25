abstract class ShopState {}

class LoginInitState extends ShopState {}

class LoginLoadState extends ShopState {}

class LoginSuccessState extends ShopState {}

class LoginErrorState extends ShopState {
  final String error;

  LoginErrorState(this.error);
}

class ChangePasswordVisibility extends ShopState {}
