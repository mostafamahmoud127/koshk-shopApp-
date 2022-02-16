import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/categories/categories_model.dart';
import 'package:shop/models/favorites/change_favorites_model.dart';
import 'package:shop/models/favorites/favorites_model.dart';
import 'package:shop/models/home/home_model.dart';
import 'package:shop/models/user/user_model.dart';
import 'package:shop/modules/categories/catigories_screen.dart';
import 'package:shop/modules/favorites/favorites_screen.dart';
import 'package:shop/modules/login/shop_login_screen.dart';
import 'package:shop/modules/products/proudcts_screen.dart';
import 'package:shop/modules/settings/settings_screen.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/components/constants.dart';
import 'package:shop/shared/cubit/states.dart';
import 'package:shop/shared/network/local/cache_helper.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';
import 'package:shop/shared/network/end_points.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitState());

  AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  bool isDark = false;

  bool load = false;
  bool favload = false;
  bool uload = false;
  IconData loginsuffix = Icons.visibility_outlined;
  IconData regsuffix = Icons.visibility_outlined;
  bool loginispassword = true;
  bool regispassword = true;

  late ShopLoginModel loginModel;
  late ShopLoginModel regModel;

  List<Widget> screens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());

    DioHelper.postData(
      url: login,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      loginModel = ShopLoginModel(value?.data);
      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error) {
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  void loginchangePasswordVisibility() {
    loginispassword = !loginispassword;
    loginsuffix = loginispassword
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;

    emit(ShopLoginChangePasswordVisibilityState());
  }

  late HomeModel homeModel;

  void getHomeData() {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
      url: home,
      token: token,
    ).then((value) {
      homeModel = HomeModel(value?.data);
      load = true;

      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      emit(ShopErrorHomeDataState());
    });
  }

  late CategoriesModel categoriesModel;

  void getCategories() {
    DioHelper.getData(
      url: getcatrgories,
    ).then((value) {
      categoriesModel = CategoriesModel(value?.data);

      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      emit(ShopErrorCategoriesState());
    });
  }

  late FavoritesModel favoritesModel;

  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(url: favorites, token: token).then((value) {
      favoritesModel = FavoritesModel(value?.data);
      favload = true;
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      emit(ShopErrorGetFavoritesState());
    });
  }

  late ChangeFavoritesModel changeFavoritesModel;

  void changeFavorites(int productId) {
    DioHelper.postData(
      url: favorites,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel(value?.data);
      if (changeFavoritesModel.status) {
        getHomeData();
        getFavorites();
      }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel));
    }).catchError((error) {
      emit(ShopErrorChangeFavoritesState());
    });
  }

  late ChangeFavoritesModel logModel;

  void signout(context) {
    DioHelper.postData(
      url: logout,
      data: {
        "fcm_token": "SomeFcmToken",
      },
      token: token,
    ).then((value) {
      logModel = ChangeFavoritesModel(value?.data);
      if (logModel.status) {
        CacheHelper.removeData(
          key: 'token',
        ).then((value) {
          if (value) {
            navigateAndFinish(
              context,
              ShopLoginScreen(),
            );
          }
        });
      }
      emit(ShopSuccessLogoutState(changeFavoritesModel));
    }).catchError((error) {
      emit(ShopErrorLogoutState());
    });
  }

  late ShopLoginModel userModel;

  void getUserData() {
    emit(ShopLoadingUserDataState());

    DioHelper.getData(
      url: profile,
      token: token,
    ).then((value) {
      userModel = ShopLoginModel(value?.data);
      uload = true;
      emit(ShopSuccessUserDataState(userModel));
    }).catchError((error) {
      emit(ShopErrorUserDataState());
    });
  }

  // void updateUserData({
  //   required String name,
  //   required String email,
  //   required String phone,
  // }) {
  //   emit(ShopLoadingUpdateUserState());

  //   DioHelper.putData(
  //     url: UPDATE_PROFILE,
  //     token: token,
  //     data: {
  //       'name': name,
  //       'email': email,
  //       'phone': phone,
  //     },
  //   ).then((value) {
  //     userModel = ShopLoginModel.fromJson(value.data);
  //     printFullText(userModel.data.name);

  //     emit(ShopSuccessUpdateUserState(userModel));
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(ShopErrorUpdateUserState());
  //   });
  // }

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.saveData(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }

  void userReg({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(ShopRegisterLoadingState());

    DioHelper.postData(
      url: register,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    ).then((value) {
      emit(ShopRegisterSuccessState());
      userLogin(email: email, password: password);
    }).catchError((error) {
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  void regchangePasswordVisibility() {
    regispassword = !regispassword;
    regsuffix = regispassword
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;

    emit(ShopRegisterChangePasswordVisibilityState());
  }
}
