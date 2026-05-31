part of 'products_cubit.dart';

@immutable
sealed class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object?> get props => [];
}

final class ProductsLoading extends ProductsState {
  const ProductsLoading();
}

final class ProductsLoaded extends ProductsState {
  final List<ProductModel> productList;

  const ProductsLoaded(this.productList);

  @override
  List<Object?> get props => [productList];
}

final class ProductsError extends ProductsState {
  final String errorMessage;

  const ProductsError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
