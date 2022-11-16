import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/controller/bloc/states/searchStates.dart';
import 'package:shop_app/model/SearchModel.dart';

import '../../services/api.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;

  Future<void> searchProducts(String text) async {
    emit(SearchLoadingState());
    try {
      final res = await Api().api.post('products/search', data: {'text': text});
      searchModel = SearchModel.fromJson(res.data);
      emit(SearchSuccessState());
    } catch (error) {
      print(error.toString());
      emit(SearchErrorState());
    }
  }
}
