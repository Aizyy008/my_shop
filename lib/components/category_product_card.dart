import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_store/utilities/color_converter.dart';

import '../models/products.dart';
import '../utilities/screen_utils.dart';

class CategoryProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;
  const CategoryProductCard({super.key, required this.product,required this.onTap,});

  /// Function to determine the number of stars based on rating
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

    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                product.images!.isNotEmpty
                    ? product.images!.first.toString()
                    : 'https://via.placeholder.com/150', // Default image
                height: 120,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: screenSize.width * 0.028),
                        child: Text(product.title ?? 'No title',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: ColorConverter.fromHex("#0C0C0C"))),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: screenSize.width * 0.01),
                        child: Text("\$${product.price?.toStringAsFixed(2) ?? '0.00'}",
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: ColorConverter.fromHex("#0C0C0C"))),
                      ),
                    ],
                  ),
                  SizedBox(height: screenSize.height * 0.004),
                  Padding(
                    padding: EdgeInsets.only(left: screenSize.width * 0.028),
                    child: Row(
                      children: [
                        Text(product.rating?.toStringAsFixed(1) ?? '0.0',
                            style: GoogleFonts.poppins(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: ColorConverter.fromHex("#0C0C0C"))),
                        SizedBox(width: screenSize.width * 0.01),
                        Row(
                          children: List.generate(
                            getStarCount(product.rating ?? 0.0),
                                (index) => const Icon(Icons.star,
                                color: Colors.amber, size: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.01),
                  Padding(
                    padding: EdgeInsets.only(left: screenSize.width * 0.028),
                    child: Text("By ${product.brand ?? 'Unknown'}",
                      style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,color: Colors.grey),
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.02),
                  Padding(
                    padding: EdgeInsets.only(left: screenSize.width * 0.028),
                    child: Text("In ${product.category ?? 'Unknown'}",
                        style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: ColorConverter.fromHex("#0C0C0C"))),
                  ),
                  SizedBox(height: screenSize.height * 0.015,)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
