import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/controller/bloc/cubits/shopCubit.dart';
import 'package:shop_app/controller/bloc/states/shopStates.dart';
import 'package:shop_app/view/components.dart';

import '../../model/FavoritesModel.dart';

class FavouritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (ctx, state) {},
      builder: (ctx, state) {
        ShopCubit cubit = ShopCubit.get(ctx);
        return state is ShopLoadingGetFavorites
            ? const Center(
                child: CircularProgressIndicator(color: primaryColor))
            : ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: cubit.favoritesModel!.data!.data!.length,
                separatorBuilder: (cx, index) => const SizedBox(height: 8),
                itemBuilder: (cx, index) {
                  final Product? favoriteProduct =
                      cubit.favoritesModel?.data?.data?[index].product;
                  return favoriteItemWidget(cubit, favoriteProduct);
                },
              );
      },
    );
  }

  Container favoriteItemWidget(ShopCubit cubit, Product? favoriteProduct) {
    return Container(
      height: 150,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image(
                image: NetworkImage(favoriteProduct!.image!.toString()),
                height: 100,
                width: 100,
                fit: BoxFit.contain,
              ),
              if (favoriteProduct.discount != 0)
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
                      fontSize: 10,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  favoriteProduct.name!,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      "${favoriteProduct.price} \$",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.greenAccent,
                      ),
                    ),
                    const SizedBox(width: 5),
                    if (favoriteProduct.discount != 0)
                      Text(
                        "${favoriteProduct.oldPrice} \$",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    const Spacer(),
                    InkWell(
                      onTap: () => cubit.changeFavorite(favoriteProduct.id!),
                      child: const CircleAvatar(
                        backgroundColor: Colors.redAccent,
                        child: Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
