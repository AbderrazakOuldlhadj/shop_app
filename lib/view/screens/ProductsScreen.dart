import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/controller/bloc/cubits/shopCubit.dart';
import 'package:shop_app/controller/bloc/states/shopStates.dart';
import 'package:shop_app/model/HomeModel.dart';
import 'package:shop_app/view/components.dart';

import '../../model/CategoriesModel.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (ctx, state) {
        if (state is ShopSuccessChangeFavorite && !state.model.status) {
          showToast(state.model.message);
        }
      },
      builder: (ctx, state) {
        ShopCubit cubit = ShopCubit.get(ctx);

        return cubit.homeModel == null || cubit.categoriesModel == null
            ? const Center(
                child: CircularProgressIndicator(color: primaryColor))
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    bannersWidget(cubit, context),
                    const SizedBox(height: 10),
                    categoriesWidget(cubit),
                    const SizedBox(height: 10),
                    productsWidget(cubit, context),
                  ],
                ),
              );
      },
    );
  }

  CarouselSlider bannersWidget(ShopCubit cubit, BuildContext context) {
    return CarouselSlider(
      items: cubit.homeModel?.data.banners
          .map(
            (banner) => Image(
              image: NetworkImage(banner.image),
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          )
          .toList(),
      options: CarouselOptions(
        autoPlay: true,
        reverse: false,
        initialPage: 0,
        enableInfiniteScroll: true,
        //autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(seconds: 1),
        height: MediaQuery.of(context).size.height * 0.25,
        viewportFraction: 1.0,
      ),
    );
  }

  GridView productsWidget(ShopCubit cubit, BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(5),
      itemCount: cubit.homeModel!.data.products.length,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.5,
        childAspectRatio: 1 / 1.17,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        ProductModel product = cubit.homeModel!.data.products[index];
        return productItem(cubit, product);
      },
    );
  }

  Padding categoriesWidget(ShopCubit cubit) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Categories", style: titleTextStyle),
          const SizedBox(height: 10),
          SizedBox(
            height: 100,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: cubit.categoriesModel!.data.data.length,
              separatorBuilder: (ctx, index) => const SizedBox(width: 8),
              itemBuilder: (ctx, index) {
                final categoryModel = cubit.categoriesModel!.data.data[index];
                return categoriesItem(categoryModel);
              },
            ),
          ),
          const SizedBox(height: 10),
          const Text("New Products", style: titleTextStyle),
        ],
      ),
    );
  }

  Container productItem(ShopCubit cubit, ProductModel product) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.3),
            offset: const Offset(3, 3),
            blurRadius: 5,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image(
                image: NetworkImage(product.image),
                height: 100,
                width: double.infinity,
                fit: BoxFit.fitHeight,
              ),
              if (product.discount != 0)
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 3),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Text(
                    "DISCOUNT",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            product.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 3),
          Row(
            children: [
              Column(
                children: [
                  Text(
                    "${product.price} \$",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.greenAccent,
                    ),
                  ),
                  const SizedBox(width: 5),
                  if (product.discount != 0)
                    Text(
                      "${product.oldPrice} \$",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                ],
              ),
              const Spacer(),
              InkWell(
                onTap: () => cubit.changeFavorite(product.id),
                child: CircleAvatar(
                  backgroundColor: cubit.favourites[product.id]!
                      ? Colors.redAccent
                      : Colors.transparent,
                  child: Icon(
                    Icons.favorite_border,
                    color: cubit.favourites[product.id]!
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget categoriesItem(DataModel categoryModel) => SizedBox(
        height: 100,
        width: 100,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image(
              image: NetworkImage(categoryModel.image),
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
            Container(
              width: 100,
              color: Colors.black.withOpacity(.7),
              child: Text(
                categoryModel.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
      );
}
