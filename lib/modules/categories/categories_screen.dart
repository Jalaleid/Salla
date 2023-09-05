// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:untitled/layout/cubit/shop_layout_cubit.dart';
import 'package:untitled/layout/cubit/shop_layout_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocConsumer;
import 'package:untitled/models/category.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
            itemBuilder: (context, index) => BuildCatItem(
                ShopLayoutCubit.get(context).categoriesModel!.data.data[index]),
            separatorBuilder: (context, index) => const Divider(
                  thickness: 1,
                ),
            itemCount:
                ShopLayoutCubit.get(context).categoriesModel!.data.data.length);
      },
    );
  }
}

Widget BuildCatItem(DataModel model) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Row(
      children: [
        Image.network(
          model.image!,
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          model.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const Spacer(),
        IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_forward_ios),
            splashRadius: 20),
      ],
    ),
  );
}
