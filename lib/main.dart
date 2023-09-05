// ignore_for_file: unnecessary_null_comparison, must_be_immutable, depend_on_referenced_packages, duplicate_ignore, avoid_print

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages, unnecessary_import
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/cubit/shop_layout_cubit.dart';
import 'package:untitled/layout/cubit/shop_layout_state.dart';
import 'layout/shop_layout.dart';
import 'modules/on_boarding/on_boarding_screen.dart';
import 'modules/shop_login/shop_login.dart';
import 'shared/components/constants.dart';
import 'shared/network/bloc_observe.dart';
import 'shared/network/local/cache_helper.dart';
import 'shared/network/remote/dio_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();

  onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  print(token);
  Widget widget = OnBoardingScreen();

  if (onBoarding != null) {
    if (token != null) {
      widget = const ShopLayout();
    } else {
      widget = ShopLoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  Widget? startWidget = OnBoardingScreen();

  MyApp({super.key, required this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => ShopLayoutCubit()
              ..getHomeData()
              ..getCategories()
              ..getFavorites()
              ..getUserData()),
      ],
      child: BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: startWidget,
          );
        },
      ),
    );
  }
}
