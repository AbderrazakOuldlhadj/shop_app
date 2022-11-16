import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/controller/bloc/cubits/searchCubit.dart';
import 'package:shop_app/controller/bloc/states/searchStates.dart';
import 'package:shop_app/view/components.dart';

import '../../model/SearchModel.dart';

class SearchScreen extends StatelessWidget {
  static const routeName = '/search';

  TextEditingController searchController = TextEditingController();
  Timer? debounce;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (ctx, state) {},
        builder: (ctx, state) {
          SearchCubit cubit = SearchCubit.get(ctx);
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: searchController,
                    cursorColor: primaryColor,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      hintText: "Search",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: primaryColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: primaryColor),
                      ),
                    ),
                    onChanged: (value) {
                      if (debounce?.isActive ?? false) {
                        debounce!.cancel();
                      }
                      debounce = Timer(const Duration(milliseconds: 500), () {
                        if (value.isNotEmpty) {
                          cubit.searchProducts(value);
                          print(value);
                        }
                      });
                    },
                  ),
                  if (state is SearchLoadingState)
                    LinearProgressIndicator(color: primaryColor),
                  SizedBox(height: 10),
                  Expanded(
                    child: cubit.searchModel == null
                        ? Center(child: Text("Search", style: titleTextStyle))
                        : ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            itemCount: cubit.searchModel!.data!.data!.length,
                            separatorBuilder: (cx, index) =>
                                const SizedBox(height: 8),
                            itemBuilder: (cx, index) {
                              final Product? searchProduct =
                                  cubit.searchModel?.data?.data?[index];
                              return searchItemWidget(cubit, searchProduct);
                            },
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Container searchItemWidget(SearchCubit cubit, Product? searchProduct) {
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
                image: NetworkImage(searchProduct!.image!.toString()),
                height: 100,
                width: 100,
                fit: BoxFit.contain,
              ),
              if (searchProduct.discount != 0)
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
                  searchProduct.name!,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,

                  ),
                ),
                const Spacer(),
                Text(
                  "${searchProduct.price} \$",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.greenAccent,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
