import 'package:shop/models/favorites/change_favorites_model.dart';
import 'package:shop/models/user/user_model.dart';

abstract class AppStates {}

class InitState extends AppStates {}

class AppChangeBottomNavBarState extends AppStates {}

class AppChangeModeState extends AppStates {}

class ShopLoginInitialState extends AppStates {}

class ShopLoginLoadingState extends AppStates {}

class ShopLoginSuccessState extends AppStates {
  final ShopLoginModel loginModel;

  ShopLoginSuccessState(this.loginModel);
}

class ShopLoginErrorState extends AppStates {
  final String error;

  ShopLoginErrorState(this.error);
}

class ShopLoginChangePasswordVisibilityState extends AppStates {}

class ShopLoadingHomeDataState extends AppStates {}

class ShopSuccessHomeDataState extends AppStates {}

class ShopErrorHomeDataState extends AppStates {}

class ShopSuccessCategoriesState extends AppStates {}

class ShopErrorCategoriesState extends AppStates {}

class ShopSuccessChangeFavoritesState extends AppStates {
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesState(this.model);
}

class ShopErrorChangeFavoritesState extends AppStates {}

class ShopSuccessLogoutState extends AppStates {
  final ChangeFavoritesModel model;

  ShopSuccessLogoutState(this.model);
}

class ShopErrorLogoutState extends AppStates {}

class ShopLoadingGetFavoritesState extends AppStates {}

class ShopSuccessGetFavoritesState extends AppStates {}

class ShopErrorGetFavoritesState extends AppStates {}

class ShopLoadingUserDataState extends AppStates {}

class ShopSuccessUserDataState extends AppStates {
  final ShopLoginModel loginModel;

  ShopSuccessUserDataState(this.loginModel);
}

class ShopErrorUserDataState extends AppStates {}

class ShopLoadingUpdateUserState extends AppStates {}

class ShopSuccessUpdateUserState extends AppStates {
  final ShopLoginModel loginModel;

  ShopSuccessUpdateUserState(this.loginModel);
}

class ShopErrorUpdateUserState extends AppStates {}

class ShopRegisterInitialState extends AppStates {}

class ShopRegisterLoadingState extends AppStates {}

class ShopRegisterSuccessState extends AppStates {}

class ShopRegisterErrorState extends AppStates {
  final String error;

  ShopRegisterErrorState(this.error);
}

class ShopRegisterChangePasswordVisibilityState extends AppStates {}
