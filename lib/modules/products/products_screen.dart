// ignore_for_file: unnecessary_null_comparison, non_constant_identifier_names, depend_on_referenced_packages, use_key_in_widget_constructors, must_be_immutable, avoid_print

import 'package:flutter/material.dart';
import 'package:untitled/layout/cubit/shop_layout_cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:untitled/layout/cubit/shop_layout_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:untitled/models/category.dart';
import 'package:untitled/models/home_model.dart';
import 'package:untitled/shared/components/components.dart';

class ProductsScreen extends StatelessWidget {
  CarouselController cc = CarouselController();
  PageController pc = PageController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state) {
        if (state is ShopSuccessChangeFavoritesState) {
          if (!state.model.status) {
            showToast(text: state.model.message, state: ToastStats.ERROR);
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopLayoutCubit.get(context).homeModel != null &&
              ShopLayoutCubit.get(context).categoriesModel != null,
          builder: (BuildContext context) => ProductsBuilder(
              ShopLayoutCubit.get(context).homeModel!,
              ShopLayoutCubit.get(context).categoriesModel!,
              context),
          fallback: (BuildContext context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget ProductsBuilder(
          HomeModel model, CategoriesModel categoriesModel, context) =>
      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            CarouselSlider.builder(
              itemCount: model.data!.banners.length,
              itemBuilder: (context, index, realIndex) => Image.network(
                model.data!.banners[index].image!,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              options: CarouselOptions(
                  pauseAutoPlayOnTouch: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  viewportFraction: 1.0,
                  height: 250.0,
                  initialPage: 2,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                  disableCenter: true),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Categorys',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 100,
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) =>
                            BuildCategoryItem(categoriesModel.data.data[index]),
                        separatorBuilder: (context, index) => const SizedBox(
                              width: 10,
                            ),
                        itemCount: categoriesModel.data.data.length),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'New Products',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 1.1,
                crossAxisSpacing: 1.1,
                childAspectRatio: 1 / 1.5,
                children: List.generate(
                  model.data!.products.length,
                  (index) =>
                      BuildproductGrid(model.data!.products[index], context),
                ),
              ),
            ),
          ],
        ),
      );

  Widget BuildCategoryItem(DataModel model) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image.network(
          model.image!,
          height: 100,
          width: 100,
          fit: BoxFit.contain,
        ),
        Container(
          width: 100,
          color: Colors.black26.withOpacity(0.6),
          child: Text(
            model.name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }

  Widget BuildproductGrid(ProductModel model, context) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 1.6,
            )
          ],
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Image.network(
                    model.image!,
                    width: double.infinity,
                    height: 200.0,
                  ),
                ),
                if (model.discount != 0)
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
                  )
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 11.0, right: 11.0, bottom: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    model.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13.0,
                      height: 1.3,
                    ),
                  ),
                  const Divider(color: Colors.deepPurple),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${model.price.round()} \$',
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
                            '${model.oldPrice}',
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
                              (ShopLayoutCubit.get(context)
                                          .favorites[model.id] ??
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
                            onPressed: () async {
                              ShopLayoutCubit.get(context)
                                  .changeFavorites(model.id!);
                              print(model.id);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
