

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/controller/cubit/states.dart';

class ShopCubit extends Cubit<ShopState>{

  ShopCubit() : super(LoginInitState());

  static ShopCubit get(context) => BlocProvider.of(context);

  bool isObscure = true ;

  void setObscure(bool value){
    isObscure = value ;
    emit(ChangePasswordVisibility());
  }
}