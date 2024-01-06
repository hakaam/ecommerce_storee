import 'package:bloc/bloc.dart';
import 'package:ecommerce_store/bloc/products_bloc/products_states.dart';
import 'package:ecommerce_store/models/product_model.dart';
import 'package:ecommerce_store/services/products_service.dart';

import '../cartbloc/cart_cubit.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductService productService;
  final CartCubit cartCubit;

  ProductCubit(this.productService, this.cartCubit) : super(ProductInitial());

  Future<void> fetchProducts() async {
    try {
      emit(ProductLoading());

      final List<Map<String, dynamic>> productMaps = await ProductService.fetchProducts();

      final List<ProductModel> products = productMaps.map((map) {
        return ProductModel.fromMap(map);
      }).toList();

      emit(ProductLoadSuccess(products));
    } catch (e) {
      emit(ProductLoadFailure('Error fetching products: $e'));
    }
  }
  Future<void> fetchProductsByCategory(String categoryName) async {
    try {
      emit(ProductLoading());
      final List<ProductModel> products =
      await productService.fetchProductsByCategory(categoryName);
      emit(ProductLoadSuccess(products));
    } catch (e) {
      emit(ProductLoadFailure('Error fetching products: $e'));
    }
  }

  Future<void> searchProducts(String query) async {
    try {
      emit(ProductLoading());

      final List<Map<String, dynamic>> productMaps =
      await productService.searchProducts(query);

      // Convert product maps to ProductModels
      final List<ProductModel> products = productMaps.map((map) {
        return ProductModel.fromMap(map);
      }).toList();

      emit(ProductLoadSuccess(products));
    } catch (e) {
      emit(ProductLoadFailure('Error searching products: $e'));
    }
  }
  void addItemToCart(ProductModel product) {
    print('Adding item to cart: $product');

    try {
      if (cartCubit != null) {
        cartCubit.addItemToCart(product);

        if (state is ProductLoadSuccess) {
          final List<ProductModel> currentProducts = (state as ProductLoadSuccess).products;

          final List<ProductModel> updatedProducts = List.from(currentProducts)..add(product);

          emit(ProductLoadSuccess(updatedProducts));
        }
      } else {
        emit(ProductLoadFailure('Cart service is not available'));
      }
    } catch (e) {
      emit(ProductLoadFailure('Error adding item to cart: $e'));
    }
  }



}
