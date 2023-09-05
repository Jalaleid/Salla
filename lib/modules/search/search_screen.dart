// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/modules/favorites/favorites_screen.dart';
import 'package:untitled/modules/search/cubit/search_cubit.dart';
import 'package:untitled/modules/search/cubit/search_states.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var fromkey = GlobalKey<FormState>();
    var searchcontroller = TextEditingController();
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Form(
                key: fromkey,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: searchcontroller,
                        decoration: const InputDecoration(
                          label: Text('Search'),
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.search),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter text to search';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          SearchCubit.get(context).search(value);
                        },
                      ),
                      if (state is SearchLoadingState)
                        const CircularProgressIndicator(),
                      const SizedBox(
                        height: 10,
                      ),
                      if (state is SearchSuccsessState)
                        Expanded(
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) => buildFavItem(
                                SearchCubit.get(context)
                                    .model
                                    ?.data
                                    ?.data![index],
                                context,
                                isOldPrice: false),
                            separatorBuilder: (context, index) => const Divider(
                              thickness: 1,
                            ),
                            itemCount: SearchCubit.get(context)
                                    .model
                                    ?.data!
                                    .data!
                                    .length ??
                                0,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
