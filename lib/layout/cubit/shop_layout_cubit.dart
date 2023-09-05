// ignore: duplicate_ignore
// ignore: depend_on_referenced_packages
// ignore_for_file: depend_on_referenced_packages, avoid_print, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/models/category.dart';
import 'package:untitled/models/change_favorites.dart';
import 'package:untitled/models/favorites.dart';
import 'package:untitled/models/home_model.dart';
import 'package:untitled/models/login_model.dart';
import 'package:untitled/modules/categories/categories_screen.dart';
import 'package:untitled/modules/favorites/favorites_screen.dart';
import 'package:untitled/modules/products/products_screen.dart';
import 'package:untitled/modules/settings/settings_screen.dart';
import 'package:untitled/shared/components/constants.dart';
import 'package:untitled/shared/network/end_points.dart';
import 'package:untitled/shared/network/remote/dio_helper.dart';
import 'shop_layout_state.dart';

class ShopLayoutCubit extends Cubit<ShopLayoutStates> {
  ShopLayoutCubit() : super(ShopLayoutInitialState());

  static ShopLayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreen = [
    ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    SettingsScreen()
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopLayoutChangBottomNavState());
  }

  HomeModel? homeModel;
  Map<int?, bool?> favorites = {};
  void getHomeData() {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      print('status is Home Data');
      print(homeModel?.status);
      for (var element in homeModel!.data!.products) {
        favorites.addAll({
          element.id: element.inFavorites,
        });
      }
      // ignore: avoid_function_literals_in_foreach_calls
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;
  void getCategories() {
    emit(ShopLoadingCategoriesState());

    DioHelper.getData(
      url: GET_CATEGORY,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      print('status is CategoriesModel Data');
      print(categoriesModel?.status);
      // ignore: avoid_function_literals_in_foreach_calls
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int productID) {
    favorites[productID] = !favorites[productID]!;
    emit(ShopChangeFavoritesState());

    DioHelper.postData(
      url: Favorites,
      data: {
        'product_id': productID,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);
      if (!(changeFavoritesModel?.status ?? false)) {
        favorites[productID] = !favorites[productID]!;
      } else {
        getFavorites();
      }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error) {
      print(error.toString());
      favorites[productID] = !favorites[productID]!;
      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavoritesModel? favoritesModel;
  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      url: Favorites,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      print('status is Favorites');
      print(favoritesModel?.status);
      // ignore: avoid_function_literals_in_foreach_calls
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }

  ShopLoginModel? UserModel;
  void getUserData() {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url: PROFILFE,
      token: token,
    ).then((value) {
      UserModel = ShopLoginModel.fromJson(value.data);
      print('status is User Data');
      print(UserModel?.data!.name!);
      // ignore: avoid_function_literals_in_foreach_calls
      emit(ShopSuccessUserDataState(UserModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }

  void updateUserData(
      {required String name, required String email, required String phone}) {
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {'name': name, 'email': email, 'phone': phone},
    ).then((value) {
      UserModel = ShopLoginModel.fromJson(value.data);
      print('status is User Data');
      print(UserModel?.data!.name!);
      // ignore: avoid_function_literals_in_foreach_calls
      emit(ShopSuccessUpdateUserState(UserModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserState());
    });
  }
}
