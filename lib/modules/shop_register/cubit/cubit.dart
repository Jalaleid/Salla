// ignore_for_file: depend_on_referenced_packages, avoid_print, non_constant_identifier_names, unused_local_variable, use_build_context_synchronously, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/models/login_model.dart';

import 'package:untitled/modules/shop_register/cubit/states.dart';
import 'package:untitled/shared/network/end_points.dart';
import 'package:untitled/shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopLoadingInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  void UserRegister(
      {required String name,
      required String email,
      required String password,
      required String phone}) {
    ShopLoginModel shopLoginModel;
    emit(ShopRegisterLoadingState());
    DioHelper.postData(url: Register, data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone
    }).then((value) {
      print(value.data);
      shopLoginModel = ShopLoginModel.fromJson(value.data);

      emit(ShopRegisterSucsessState(shopLoginModel));
    }).catchError((onError) {
      print(onError.toString());

      emit(ShopRegisterErrorState(onError.toString()));
    });
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;

  void changePasswoedVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopRegisterChangePasswordVisibilityState());
  }

  // function to implement the google signin

// creating firebase instance
}
