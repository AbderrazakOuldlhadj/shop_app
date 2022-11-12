import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/model/LoginModel.dart';
import 'package:shop_app/view/components.dart';

import '../../services/api.dart';
import '../states/loginStates.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitState());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isObscure = true;

  void setObscure(bool value) {
    isObscure = value;
    emit(ChangePasswordVisibility());
  }

  void userLogin({required String email, required String password}) {
    emit(LoginLoadState());
    Api().api.post(
      "login",
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      print(value.data);
      emit(LoginSuccessState(LoginModel.fromJson(value.data)));

    }).onError((error, stackTrace) {
      print(error);
      emit(LoginErrorState(error.toString()));
    });
  }

  void userLogout() {
    emit(LogoutLoadState());
    Api().api.post(
      "logout",
      data: {
        'fcm_token' : 'SomeFcmToken'
      },
    ).then((value) {
      print(value.data);
      emit(LogoutSuccessState());

    }).onError((error, stackTrace) {
      print(error);
      emit(LogoutErrorState(error.toString()));
    });
  }
}
