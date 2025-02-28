import "package:flutter/material.dart";

import "package:google_fonts/google_fonts.dart";
import "package:my_store/models/products.dart";
import "package:my_store/utilities/color_converter.dart";
import "package:provider/provider.dart";
import "../providers/wishlist_provider.dart";
import "../utilities/screen_utils.dart";



class ProductDescScreen extends StatefulWidget {
  final Product product;
  const ProductDescScreen({super.key, required this.product});

  @override
  State<ProductDescScreen> createState() => _ProductDescScreenState();
}

class _ProductDescScreenState extends State<ProductDescScreen> {


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
    List<String> images = [
      widget.product.images!.first.toString(),
      widget.product.images!.first.toString(),
      widget.product.images!.first.toString(),
      widget.product.images!.first.toString(),
      widget.product.images!.first.toString(),widget.product.images!.first.toString(),

    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Product Details",
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                            widget.product.images!.first.toString(),
                            height: screenSize.height * 0.3,
                          ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: screenSize.width * 0.05,
                  right: screenSize.width * 0.05,
                  top: screenSize.height * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Product Details:",
                    style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: ColorConverter.fromHex("#0C0C0C")),
                  ),
                  Consumer<WishlistProvider>(
                    builder: (context, wishlistProvider, child){
                      return InkWell(
                          onTap: () {
                            wishlistProvider.toggleWishlist(widget.product);

                          },
                          child:  wishlistProvider.isInWishlist(widget.product.id!)
                              ? Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 30,
                          )
                              : Icon(
                            Icons.favorite_border,
                            color: ColorConverter.fromHex("#0C0C0C"),
                            size: 30,
                          ));
                    },
                  )
                ],
              ),
            ),
            SizedBox(height: screenSize.height * 0.02,),
            contentRow("Name: ", widget.product.title.toString(), context),
            SizedBox(height: screenSize.height * 0.02,),
            contentRow("Price: ", "\$${widget.product.price?.toStringAsFixed(2)}", context),
            SizedBox(height: screenSize.height * 0.02,),
            contentRow("Category: ", widget.product.category.toString(), context),
            SizedBox(height: screenSize.height * 0.02,),
            contentRow("Brand: ", widget.product.brand.toString(), context),
            SizedBox(height: screenSize.height * 0.02,),
            Row(
              children: [
                contentRow("Rating: ", widget.product.rating?.toStringAsFixed(1), context),
                SizedBox(width: screenSize.width * 0.01),
                Row(
                  children: List.generate(
                    getStarCount(widget.product.rating ?? 0.0),
                        (index) => const Icon(Icons.star,
                        color: Colors.amber, size: 16),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenSize.height * 0.02,),
            contentRow("Stock: ", widget.product.stock.toString(), context),
            SizedBox(height: screenSize.height * 0.02,),
            Padding(
              padding: EdgeInsets.only(left:screenSize.width * 0.05 ),
              child: Text("Description: ",style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: ColorConverter.fromHex("#0C0C0C")
              )),
            ),
            SizedBox(height: screenSize.height * 0.01,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal:screenSize.width * 0.05 ),
              child: Text(widget.product.description.toString(), style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                  color: ColorConverter.fromHex("#0C0C0C")
              )),
            ),
            SizedBox(height: screenSize.height * 0.02,),
            Padding(
              padding: EdgeInsets.only(left:screenSize.width * 0.05 ),
              child: Text("Product Gallery: ",style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: ColorConverter.fromHex("#0C0C0C")
              )),
            ),
            Center(
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(), // Disable internal scrolling
                itemCount: (images.length / 2).ceil(), // 2 items per row
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05), // Uniform padding
                    child: Row(
                      children: [
                        Expanded(
                          child: buildImageContainer(images[index * 2]), // First container
                        ),
                        SizedBox(width: 8), // Add spacing between containers
                        if (images.length > (index * 2) + 1) // Check if second container exists
                          Expanded(
                            child: buildImageContainer(images[(index * 2) + 1]), // Second container
                          ),
                      ],
                    ),
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

Widget contentRow(String? mainHeading, String? value, BuildContext context){
  final screenSize = ScreenUtils(context);
  return Padding(
    padding: EdgeInsets.only(left:screenSize.width * 0.05 ),
    child: RichText(text: TextSpan(
      children: [
        TextSpan(
          text: mainHeading,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: ColorConverter.fromHex("#0C0C0C")
          )
        ),
       const TextSpan(text: "   "),
       TextSpan(
         text: value,
           style: GoogleFonts.poppins(
               fontWeight: FontWeight.w400,
               fontSize: 10,
               color: ColorConverter.fromHex("#0C0C0C")
           )
       )
      ]
    )),
  );
}


Widget buildImageContainer(String imageUrl) {
  return Container(
    height: 150, // Fixed height
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      image: DecorationImage(
        image: NetworkImage(imageUrl),
        fit: BoxFit.cover,
      ),
    ),
  );
}
