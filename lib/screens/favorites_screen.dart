import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:google_fonts/google_fonts.dart";
import "package:my_store/utilities/color_converter.dart";
import "package:provider/provider.dart";
import "../models/products.dart";
import "../utilities/screen_utils.dart";
import "../providers/wishlist_provider.dart";

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  TextEditingController searchController = TextEditingController();
  List<Product> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final wishlistProvider =
          Provider.of<WishlistProvider>(context, listen: false);
      setState(() {
        filteredProducts = wishlistProvider.getWishlistProducts();
      });
    });
  }

  // Filter products based on search input
  void filterProducts(String query) {
    final wishlistProvider =
        Provider.of<WishlistProvider>(context, listen: false);
    setState(() {
      filteredProducts =
          wishlistProvider.getWishlistProducts().where((product) {
        final titleMatch =
            product.title?.toLowerCase().contains(query.toLowerCase());
        return titleMatch!;
      }).toList();
    });
  }

  int getStarCount(double rating) {
    if (rating >= 4.6) return 5;
    if (rating >= 3.6) return 4;
    if (rating >= 2.6) return 3;
    if (rating >= 1.6) return 2;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = ScreenUtils(context);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final wishlistProducts = wishlistProvider.getWishlistProducts();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Favorites",
          style: GoogleFonts.playfairDisplay(
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(
              height: screenSize.height * 0.02), // Using screenSize for spacing
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal:
                    screenSize.width * 0.04), // Using screenSize for padding
            child: TextFormField(
              controller: searchController,
              onChanged: filterProducts,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: EdgeInsets.all(screenSize.width *
                      0.03), // Using screenSize for icon padding
                  child: SvgPicture.asset(
                    'assets/icons/search.svg',
                    width: 20, // Static size for icon
                    height: 20, // Static size for icon
                    fit: BoxFit.contain,
                  ),
                ),
                hintText: "Search by name...",
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
          ),
          SizedBox(
              height: screenSize.height * 0.02), // Using screenSize for spacing
          Expanded(
            child: wishlistProducts.isEmpty
                ? Center(child: Text("No items in wishlist"))
                : ListView.builder(
                    itemCount: filteredProducts.isEmpty
                        ? wishlistProducts.length
                        : filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts.isEmpty
                          ? wishlistProducts[index]
                          : filteredProducts[index];

                      return Card(
                        elevation: 3,
                        color: Colors.white,
                        margin: EdgeInsets.symmetric(
                          horizontal: screenSize.width * 0.04,
                          vertical: screenSize.height * 0.01,
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30, // Adjust the radius for size
                            backgroundColor: Colors.grey.shade200, // Optional background color
                            backgroundImage: NetworkImage(product.images!.first.toString()),
                          ),
                          title: Text(
                            product.title.toString(),
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: ColorConverter.fromHex("#0C0C0C"),
                            ),
                          ),
                          subtitle: Padding(
                            padding: EdgeInsets.only(top: screenSize.height * 0.01),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "\$${product.price}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: ColorConverter.fromHex("#0C0C0C"),
                                  ),
                                ),
                                SizedBox(height: screenSize.height * 0.01),
                                Row(
                                  children: [
                                    Text(
                                      product.rating.toString(),
                                      style: GoogleFonts.poppins(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: ColorConverter.fromHex("#0C0C0C"),
                                      ),
                                    ),
                                    Row(
                                      children: List.generate(
                                        getStarCount(product.rating ?? 0.0),
                                            (index) => const Icon(Icons.star,
                                            color: Colors.amber, size: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.favorite, color: Colors.red),
                            onPressed: () {
                              wishlistProvider.removeItem(product.id!);
                              filterProducts(searchController.text); // Update filtered list
                            },
                          ),
                        ),
                      );

                    },
                  ),
          ),
        ],
      ),
    );
  }
}
