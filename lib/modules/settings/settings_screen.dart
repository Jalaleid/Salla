// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/cubit/shop_layout_cubit.dart';
import 'package:untitled/layout/cubit/shop_layout_state.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    TextEditingController nameconroller = TextEditingController();
    TextEditingController emailconroller = TextEditingController();
    TextEditingController phoneconroller = TextEditingController();
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state) {
        if (state is ShopSuccessUserDataState) {
          nameconroller.text = state.loginModel.data!.name!;
          emailconroller.text = state.loginModel.data!.email!;
          phoneconroller.text = state.loginModel.data!.phone!;
        }
      },
      builder: (context, state) {
        var model = ShopLayoutCubit.get(context).UserModel;

        nameconroller.text = model!.data!.name!;
        emailconroller.text = model.data!.email!;
        phoneconroller.text = model.data!.phone!;

        return ConditionalBuilder(
          condition: ShopLayoutCubit.get(context).UserModel != null,
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if (state is ShopLoadingUpdateUserState)
                    const Column(
                      children: [
                        LinearProgressIndicator(),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  TextFormField(
                    controller: nameconroller,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(25),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                        label: Text('Name')),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Name must not empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: emailconroller,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(25),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                        label: Text('Email Address')),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email must not empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: phoneconroller,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(25),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone),
                        label: Text('Phone')),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'plase enter your phone';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 65,
                    child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            ShopLayoutCubit.get(context).updateUserData(
                                name: nameconroller.text,
                                email: emailconroller.text,
                                phone: phoneconroller.text);
                          }
                        },
                        child: const Text('Update')),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 65,
                    child: ElevatedButton(
                        onPressed: () {
                          SignOut(context);
                        },
                        child: const Text('Logout')),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
