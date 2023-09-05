// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, depend_on_referenced_packages, avoid_print

import 'package:flutter/material.dart';
import 'package:untitled/layout/shop_layout.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/shared/components/constants.dart';
import 'package:untitled/shared/network/local/cache_helper.dart';
import '../shop_register/shop_register.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ShopLoginScreen extends StatelessWidget {
  var fromKey = GlobalKey<FormState>();
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSucsessState) {
            if (state.shoploginmodel.status!) {
              print(state.shoploginmodel.message);
              print(state.shoploginmodel.data!.token!);
              CacheHelper.saveData(
                      key: 'token', value: state.shoploginmodel.data!.token!)
                  .then((value) {
                token = state.shoploginmodel.data!.token!;
                NavigateAndFinish(context, const ShopLayout());
              });
              showToast(
                  text: state.shoploginmodel.message!,
                  state: ToastStats.SUCCESS);
            } else {
              print(state.shoploginmodel.message);
              showToast(
                  text: state.shoploginmodel.message!, state: ToastStats.ERROR);
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
                          //algazzar.abdelrahman@gmail.com
                          'LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(color: Colors.black),
                        ),
                        Text(
                          'Login now to browse our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 30,
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
                          onFieldSubmitted: (value) {
                            if (fromKey.currentState!.validate()) {
                              ShopLoginCubit.get(context).UserLogin(
                                  email: emailcontroller.text,
                                  password: passwordcontroller.text);
                            }
                          },
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
                              return 'Psssword must not empty';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) {
                            return SizedBox(
                              height: 50,
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (state is ShopLoginSucsessState) {}
                                  if (fromKey.currentState!.validate()) {
                                    ShopLoginCubit.get(context).UserLogin(
                                        email: emailcontroller.text,
                                        password: passwordcontroller.text);
                                  }
                                },
                                child: const Text('LOGIN'),
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
                                  NavigateTo(context, ShopRegisterScreen());
                                },
                                child: const Text('Register'))
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
