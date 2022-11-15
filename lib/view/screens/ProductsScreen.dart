import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/controller/bloc/cubits/shopCubit.dart';
import 'package:shop_app/controller/bloc/states/shopStates.dart';
import 'package:shop_app/model/HomeModel.dart';
import 'package:shop_app/view/components.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (ctx, state) {},
      builder: (ctx, state) {
        ShopCubit cubit = ShopCubit.get(ctx);

        return cubit.homeModel == null
            ? const Center(
                child: CircularProgressIndicator(color: primaryColor))
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Expanded(
                  child: Column(
                    children: [
                      CarouselSlider(
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
                      ),
                      const SizedBox(height: 10),
                      GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(5),
                        itemCount: cubit.homeModel!.data.products.length,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent:
                              MediaQuery.of(context).size.width * 0.5,
                          childAspectRatio: 1 / 1.15,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) {
                          ProductModel product =
                              cubit.homeModel!.data.products[index];
                          return Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(.3),
                                  offset: const Offset(3, 3),
                                  blurRadius: 5
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
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2, horizontal: 3),
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                              decoration:
                                                  TextDecoration.lineThrough,
                                            ),
                                          ),
                                      ],
                                    ),
                                    const Spacer(),
                                    InkWell(
                                      onTap: () {},
                                      child: const Icon(Icons.favorite_border),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
