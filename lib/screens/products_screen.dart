import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_store/controller/methods.dart';
import 'package:my_store/screens/product_desc_screen.dart';
import 'package:my_store/utilities/color_converter.dart';
import '../components/product_card.dart';
import '../models/products.dart';
import '../utilities/screen_utils.dart';

class ProductsScreen extends StatefulWidget {
  final Function(bool) updateNavBarVisibility;
  const ProductsScreen({super.key, required this.updateNavBarVisibility});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  Future<ProductList?>? products;
  List<Product>? filteredProducts;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    products = getProductsList();
    products!.then((data) {
      setState(() {
        filteredProducts = data?.products ?? [];
      });
    });
  }

  void filterProducts(String query) {
    if (query.isEmpty) {
      setState(() {
        products!.then((data) {
          filteredProducts = data?.products ?? [];
        });
      });
      return;
    }

    setState(() {
      filteredProducts = filteredProducts?.where((product) {
        final nameMatch =
            product.title!.toLowerCase().contains(query.toLowerCase());
        final categoryMatch =
            product.category!.toLowerCase().contains(query.toLowerCase());
        final brandMatch =
            product.brand!.toLowerCase().contains(query.toLowerCase());
        return nameMatch || categoryMatch || brandMatch;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = ScreenUtils(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Products",
          style: GoogleFonts.playfairDisplay(
            // Updated font to Poppins
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
        child: Column(
          children: [
            SizedBox(height: screenSize.height * 0.02),
            TextFormField(
              controller: searchController,
              onChanged: filterProducts,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: EdgeInsets.all(12),
                  child: SvgPicture.asset(
                    'assets/icons/search.svg',
                    width: 20,
                    height: 20,
                    fit: BoxFit.contain,
                  ),
                ),
                hintText: "Search by name, category, or brand...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.blue),
                ),
              ),
            ),
            SizedBox(height: screenSize.height * 0.02),
            Padding(
              padding: EdgeInsets.only(left: screenSize.width * 0.03),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "${filteredProducts?.length ?? 0} results found",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            SizedBox(height: screenSize.height * 0.02),
            Expanded(
              child: FutureBuilder<ProductList?>(
                future: products,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.blue),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "Error: ${snapshot.error}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else if (filteredProducts == null ||
                      filteredProducts!.isEmpty) {
                    return const Center(
                      child: Text(
                        "No products found.",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: filteredProducts!.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts![index];

                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: index == filteredProducts!.length - 1
                              ? screenSize.height * 0.04
                              : screenSize.height * 0.02,
                        ),
                        child: ProductCard(
                          product: product,
                          onTap: () {
                            widget.updateNavBarVisibility(false);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ProductDescScreen(product: product))).then((_) {
                              widget.updateNavBarVisibility(true); // Show nav bar when back
                            });
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
