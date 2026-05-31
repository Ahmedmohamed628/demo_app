import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/card_items.dart';
import '../../logic/cubit/products_cubit.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key, required this.title});

  final String title;
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsCubit()..getProductData(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(title),
        ),
        body: BlocBuilder<ProductsCubit, ProductsState>(
          builder: (context, state) {
            switch (state) {
              case ProductsLoading():
                return const Center(child: CircularProgressIndicator());
              case ProductsLoaded():
                return GridView.builder(
                  itemCount: state.productList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (context, index) {
                    final products = state.productList[index];
                    return CardItems(
                      title: products.title,
                      description: products.description,
                      price: products.price,
                      image: products.thumbnail,
                      category: products.category,
                      rate: products.rating.toString(),
                    );
                  },
                );
              case ProductsError():
                return Center(child: Text(state.errorMessage.toString()));
            }
          },
        ),
      ),
    );
  }
}
