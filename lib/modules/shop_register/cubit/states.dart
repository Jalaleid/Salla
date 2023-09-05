import 'package:untitled/models/login_model.dart';

abstract class ShopRegisterStates {}

class ShopLoadingInitialState extends ShopRegisterStates {}

class ShopRegisterLoadingState extends ShopRegisterStates {}

class ShopRegisterSucsessState extends ShopRegisterStates {
  final ShopLoginModel shopLoginmodel;

  ShopRegisterSucsessState(this.shopLoginmodel);
}

class ShopRegisterErrorState extends ShopRegisterStates {
  final String error;

  ShopRegisterErrorState(this.error);
}

class ShopRegisterChangePasswordVisibilityState extends ShopRegisterStates {}
