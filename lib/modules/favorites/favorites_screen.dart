// ignore_for_file: dead_code, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:untitled/layout/cubit/shop_layout_cubit.dart';
import 'package:untitled/layout/cubit/shop_layout_state.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopLayoutCubit.get(context).favoritesModel != null &&
              state is! ShopLoadingGetFavoritesState,
          builder: (context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildFavItem(
                ShopLayoutCubit.get(context)
                    .favoritesModel!
                    .data!
                    .data![index]
                    .product!,
                context),
            separatorBuilder: (context, index) => const Divider(
              thickness: 1,
            ),
            itemCount: ShopLayoutCubit.get(context)
                    .favoritesModel
                    ?.data!
                    .data!
                    .length ??
                0,
          ),
          fallback: (contetx) => Center(
            child: SvgPicture.asset(
              'assets/images/Cash Payment-rafiki.svg',
              height: 200,
              width: 200,
            ),
          ),
        );
      },
    );
  }
}

Widget buildFavItem(model, context, {bool isOldPrice = true}) {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: SizedBox(
      height: 120,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.image ?? ''),
                height: 120,
                width: 120,
                fit: BoxFit.contain,
              ),
              if (model.discount != 0 && isOldPrice)
                Container(
                  color: Colors.red,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5.5,
                    vertical: 1.5,
                  ),
                  child: const Text(
                    'DISCOUNT',
                    style: TextStyle(
                      fontSize: 11.0,
                      color: Colors.white,
                      shadows: <Shadow>[
                        Shadow(
                          color: Colors.black,
                          offset: Offset(-1.4, 1.4),
                          blurRadius: 3.5,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13.0,
                  height: 1.3,
                ),
              ),
              const Spacer(),
              const Divider(color: Colors.deepPurple),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: Row(
                  children: [
                    Text(
                      '${model.price.toString()}\$',
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.deepPurple,
                      ),
                    ),
                    if (model.discount != 0)
                      const SizedBox(
                        width: 15,
                        child: Divider(
                          color: Colors.blue,
                          indent: 2.5,
                          endIndent: 4,
                        ),
                      ),
                    if (model.discount != 0)
                      Text(
                        model.oldPrice.toString(),
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontSize: 11.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    const Spacer(),
                    SizedBox(
                      width: 24,
                      height: 21,
                      child: IconButton(
                        //color: Colors.deepPurple,
                        padding: EdgeInsets.zero,
                        splashRadius: 20,
                        //alignment: Alignment.bottomRight,
                        icon: Icon(
                          (ShopLayoutCubit.get(context).favorites[model.id] ??
                                  false)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          size: 24,
                          color: (ShopLayoutCubit.get(context)
                                      .favorites[model.id] ??
                                  false)
                              ? Colors.red
                              : Colors.grey,
                        ),
                        onPressed: () {
                          ShopLayoutCubit.get(context)
                              .changeFavorites(model.id!);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ))
        ],
      ),
    ),
  );
}
