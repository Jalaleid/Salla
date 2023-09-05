// ignore_for_file: unnecessary_import, depend_on_referenced_packages, avoid_print

import 'package:untitled/models/search_model.dart';
import 'package:untitled/modules/search/cubit/search_states.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/shared/components/constants.dart';
import 'package:untitled/shared/network/end_points.dart';
import 'package:untitled/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;

  void search(String text) {
    emit(SearchLoadingState());
    DioHelper.postData(url: SEARCH, data: {
      'text': text,
      token: token,
    }).then((value) {
      model = SearchModel.fromJson(value.data);
      print('Search status is');
      print(model?.status);
      emit(SearchSuccsessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}
