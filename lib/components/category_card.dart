import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:my_store/utilities/color_converter.dart";
import "package:my_store/utilities/screen_utils.dart";
import "../models/category.dart";

class CategoryCard extends StatelessWidget {
  final Category category;
  final VoidCallback onTap;
  final int index;
  static const List<String> imagesList = [
    "images/phone.jpeg",
    "images/laptop.jpeg",
    "images/accessories.png",
    "images/beauty.png",
  ];

  const CategoryCard({Key? key, required this.category, required this.onTap, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = ScreenUtils(context);
    final String categoryImage = imagesList[index % imagesList.length]; // Repeat images

    return Padding(
      padding: EdgeInsets.only(
        bottom: screenSize.width * 0.04, // Dynamic bottom padding
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 160, // Slightly increased height
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  categoryImage,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                padding: EdgeInsets.all(screenSize.width * 0.03),
                alignment: Alignment.bottomLeft, // Aligns text to bottom-left
                child: Text(
                  category.name,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 4,
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
