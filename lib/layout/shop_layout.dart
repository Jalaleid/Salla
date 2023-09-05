// ignore_for_file: depend_on_referenced_packages, unused_import, avoid_web_libraries_in_flutter, non_constant_identifier_names, unused_element
import 'package:flutter/material.dart';
import 'package:untitled/layout/cubit/shop_layout_cubit.dart';
import 'package:untitled/layout/cubit/shop_layout_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/modules/search/search_screen.dart';
import 'package:untitled/modules/shop_login/shop_login.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shared/network/local/cache_helper.dart';

import '../shared/components/constants.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopLayoutCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Salla',
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              IconButton(
                  onPressed: () {
                    NavigateTo(context, const SearchScreen());
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ))
            ],
          ),
          body: cubit.bottomScreen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (value) {
              cubit.changeBottom(value);
            },
            currentIndex: cubit.currentIndex,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.apps), label: 'Categories'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'Favorite'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Settings')
            ],
          ),
        );
      },
    );
  }
}
