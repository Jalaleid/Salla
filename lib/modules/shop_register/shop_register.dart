// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, depend_on_referenced_packages, avoid_print

import 'package:flutter/material.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:untitled/modules/shop_register/cubit/cubit.dart';
import 'package:untitled/modules/shop_register/cubit/states.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/shop_layout.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/local/cache_helper.dart';
import '../shop_login/cubit/cubit.dart';
import '../shop_login/shop_login.dart';

class ShopRegisterScreen extends StatelessWidget {
  var fromKey = GlobalKey<FormState>();
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var namecontroller = TextEditingController();
  var phonecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSucsessState) {
            if (state.shopLoginmodel.status!) {
              print(state.shopLoginmodel.message);
              print(state.shopLoginmodel.data!.token!);
              CacheHelper.saveData(
                      key: 'token', value: state.shopLoginmodel.data!.token!)
                  .then((value) {
                token = state.shopLoginmodel.data!.token!;
                NavigateAndFinish(context, const ShopLayout());
              });
              showToast(
                  text: state.shopLoginmodel.message!,
                  state: ToastStats.SUCCESS);
            } else {
              print(state.shopLoginmodel.message);
              showToast(
                  text: state.shopLoginmodel.message!, state: ToastStats.ERROR);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: fromKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(color: Colors.black),
                        ),
                        Text(
                          'Resister now to browse our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: namecontroller,
                          decoration: const InputDecoration(
                            label: Text('Name'),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person_outlined),
                          ),
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
                          keyboardType: TextInputType.emailAddress,
                          controller: emailcontroller,
                          decoration: const InputDecoration(
                            label: Text('Email Adress'),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email Address must not empty';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: passwordcontroller,
                          obscureText: ShopLoginCubit.get(context).isPassword,
                          decoration: InputDecoration(
                            label: const Text('Password'),
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: InkWell(
                              onTap: () {
                                ShopLoginCubit.get(context)
                                    .changePasswoedVisibility();
                              },
                              child: Icon(ShopLoginCubit.get(context).suffix),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password must not empty';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: phonecontroller,
                          decoration: const InputDecoration(
                            label: Text('Phone'),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.phone_outlined),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Phone must not empty';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context) {
                            return SizedBox(
                              height: 50,
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (state is ShopRegisterSucsessState) {}
                                  if (fromKey.currentState!.validate()) {
                                    ShopRegisterCubit.get(context).UserRegister(
                                        email: emailcontroller.text,
                                        password: passwordcontroller.text,
                                        name: namecontroller.text,
                                        phone: phonecontroller.text);
                                  }
                                },
                                child: const Text('REGISTER'),
                              ),
                            );
                          },
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have an account?'),
                            TextButton(
                                onPressed: () {
                                  NavigateTo(context, ShopLoginScreen());
                                },
                                child: const Text('Login'))
                          ],
                        )
                      ],
                    ),
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
