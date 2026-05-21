import 'package:demo_project/models/product_model/product_model.dart';
import 'package:demo_project/repositories/product_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsLoading());
  ProductRepository productRepository = ProductRepository();

  getProductData() async {
    try {
      final List<ProductModel> products = await productRepository.getProduct();
      emit(ProductsLoaded(products));
    } on Exception catch (e) {
      emit(ProductsError(e.toString()));
    }
  }
}
