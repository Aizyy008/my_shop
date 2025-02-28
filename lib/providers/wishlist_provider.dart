import 'package:flutter/material.dart';
import '../models/products.dart';

class WishlistProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _wishlistItems = [];

  List<Map<String, dynamic>> get wishlistItems => _wishlistItems;

  bool isInWishlist(int id) {
    bool exists = _wishlistItems.any((item) => item['id'] == id);
    print('Checking if product with ID $id is in wishlist: $exists');
    return exists;
  }

  void toggleWishlist(Product product) {
    bool exists = isInWishlist(product.id!);

    if (exists) {
      _wishlistItems.removeWhere((item) => item['id'] == product.id);
      print('Removed product with ID ${product.id} from wishlist.');
    } else {
      _wishlistItems.add({
        'id': product.id,
        'wishlist': true,
        'product': product,
      });
      print('Added product with ID ${product.id} to wishlist.');
    }

    notifyListeners();
  }

  void removeItem(int id) {
    _wishlistItems.removeWhere((item) => item['id'] == id);
    print('Removed item with ID $id from wishlist.');
    notifyListeners();
  }

  List<Map<String, dynamic>> getWishlistItems() {
    List<Map<String, dynamic>> items = _wishlistItems.where((item) => item['wishlist'] == true).toList();
    print('Fetching wishlist items: ${items.length} items found.');
    return items;
  }

  List<Product> getWishlistProducts() {
    List<Product> products = _wishlistItems.map((item) => item['product'] as Product).toList();
    print('Fetching wishlist products: ${products.length} products found.');
    return products;
  }
}
