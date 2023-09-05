// ignore_for_file: depend_on_referenced_packages, avoid_print, non_constant_identifier_names, unused_local_variable, use_build_context_synchronously, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/models/login_model.dart';
import 'package:untitled/modules/shop_login/cubit/states.dart';
import 'package:untitled/shared/network/end_points.dart';
import 'package:untitled/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoadingInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  void UserLogin({required String email, required String password}) {
    ShopLoginModel shoploginmodel;
    emit(ShopLoginLoadingState());
    DioHelper.postData(url: LOGIN, data: {'email': email, 'password': password})
        .then((value) {
      print(value.data);
      shoploginmodel = ShopLoginModel.fromJson(value.data);
      // print(shoploginmodel.status);
      // print(shoploginmodel.message);
      // print(shoploginmodel.data.token);
      emit(ShopLoginSucsessState(shoploginmodel));
    }).catchError((onError) {
      print(onError.toString());

      emit(ShopLoginErrorState(onError.toString()));
    });
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;

  void changePasswoedVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopchangePasswordVisibilityState());
  }

  // function to implement the google signin

// creating firebase instance
}
