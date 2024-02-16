import 'package:collection/collection.dart';
import 'package:flutter_market/model/cart_item_model.dart';
import 'package:flutter_market/model/product_model.dart';
import 'package:mobx/mobx.dart';

part 'cart_store.g.dart';

class CartStore = _CartStore with _$CartStore;

abstract class _CartStore with Store {
  @observable
  ObservableList<CartItem> cartItems = ObservableList<CartItem>();

  @observable
  bool isBottomSheetOpen = false;

  @computed
  int get totalItems => cartItems.fold(0, (sum, item) => sum + item.amount);

  @computed
  double get totalCost => cartItems.fold(0, (sum, item) => sum + (item.amount * item.product.price));

  @action
  void toggleBottomSheet() {
    isBottomSheetOpen = !isBottomSheetOpen;
  }

  @action
  void addToCart(Product product) {
    final existingCartItem = cartItems.firstWhereOrNull((item) => item.product == product);

    if (existingCartItem != null) {
      existingCartItem.amount++;
      cartItems = ObservableList<CartItem>.of(cartItems);

    } else {
      cartItems.add(CartItem(product: product, amount: 1));
    }

  }

  @action
  void removeFromCart(Product product) {
    final existingCartItem = cartItems.firstWhereOrNull((item) => item.product == product);

    if (existingCartItem != null) {
      existingCartItem.amount--;
      if (existingCartItem.amount < 1) {
        cartItems.removeWhere((item) => item.product == product);
      }
      else {
        cartItems = ObservableList<CartItem>.of(cartItems);
      }
    }
  }



  @action
  void removeItemCompletely(Product product) {
    cartItems.removeWhere((item) => item.product == product);
  }

  @action
  void clearCart() {
    cartItems.clear();
  }
}
