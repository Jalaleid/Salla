import 'package:untitled/models/change_favorites.dart';
import 'package:untitled/models/login_model.dart';

abstract class ShopLayoutStates {}

class ShopLayoutInitialState extends ShopLayoutStates {}

class ShopLayoutChangBottomNavState extends ShopLayoutStates {}

class ShopLoadingHomeDataState extends ShopLayoutStates {}

class ShopSuccessHomeDataState extends ShopLayoutStates {}

class ShopErrorHomeDataState extends ShopLayoutStates {}

class ShopLoadingCategoriesState extends ShopLayoutStates {}

class ShopSuccessCategoriesState extends ShopLayoutStates {}

class ShopErrorCategoriesState extends ShopLayoutStates {}

class ShopChangeFavoritesState extends ShopLayoutStates {}

class ShopSuccessChangeFavoritesState extends ShopLayoutStates {
  late ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesState(this.model);
}

class ShopErrorChangeFavoritesState extends ShopLayoutStates {}

class ShopLoadingGetFavoritesState extends ShopLayoutStates {}

class ShopSuccessGetFavoritesState extends ShopLayoutStates {}

class ShopErrorGetFavoritesState extends ShopLayoutStates {}

class ShopLoadingUserDataState extends ShopLayoutStates {}

class ShopSuccessUserDataState extends ShopLayoutStates {
  final ShopLoginModel loginModel;

  ShopSuccessUserDataState(this.loginModel);
}

class ShopErrorUserDataState extends ShopLayoutStates {}

class ShopLoadingUpdateUserState extends ShopLayoutStates {}

class ShopSuccessUpdateUserState extends ShopLayoutStates {
  final ShopLoginModel loginModel;

  ShopSuccessUpdateUserState(this.loginModel);
}

class ShopErrorUpdateUserState extends ShopLayoutStates {}
