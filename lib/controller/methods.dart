import 'dart:convert';
import 'package:my_store/constants/api.dart';
import 'package:my_store/models/products.dart';
import "package:http/http.dart" as http;

import '../models/category.dart';

Future<ProductList?> getProductsList() async {
  print("Get products method called");
  try {
    final url = Uri.parse(productsAPI);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      print("Products are retrieved successfully");
      return ProductList.fromJson(jsonResponse);
    } else {
      print("Error: Failed to get products, status code: ${response.statusCode}");
      return null;
    }
  } catch (e) {
    print("Exception occurred while fetching products: $e");
    return null;
  }
}

Future<List<Category>> fetchCategories() async {
  print("Get categories method called");
  try {
    final response = await http.get(Uri.parse(categoriesAPI));

    if (response.statusCode == 200) {
      print("Categories are retrieved successfully");
      List<dynamic> jsonData = json.decode(response.body);
      return Category.fromJsonList(jsonData);
    } else {
      throw Exception('Failed to load categories');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}

Future<ProductList?> getCategoryProductsList(String api) async {
  print("Get category products method called");
  try {
    final url = Uri.parse(api);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      print("Category products are retrieved successfully");
      return ProductList.fromJson(jsonResponse);
    } else {
      print("Error: Failed to get category products, status code: ${response.statusCode}");
      return null;
    }
  } catch (e) {
    print("Exception occurred while fetching category products: $e");
    return null;
  }
}

