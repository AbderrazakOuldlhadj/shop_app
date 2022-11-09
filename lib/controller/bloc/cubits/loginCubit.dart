

import 'package:flutter_bloc/flutter_bloc.dart';

import '../states/loginStates.dart';

class LoginCubit extends Cubit<LoginState>{

  LoginCubit() : super(LoginInitState());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isObscure = true ;

  void setObscure(bool value){
    isObscure = value ;
    emit(ChangePasswordVisibility());
  }
}