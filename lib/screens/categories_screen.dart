import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_store/components/category_card.dart';
import 'package:my_store/controller/methods.dart';
import 'package:my_store/models/category.dart';
import 'package:my_store/screens/category_screen.dart';
import '../utilities/screen_utils.dart';

class CategoriesScreen extends StatefulWidget {
  final Function(bool) updateNavBarVisibility;
  const CategoriesScreen({super.key, required this.updateNavBarVisibility});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  Future<List<Category>>? categories;
  List<Category>? filteredCategories;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    categories = fetchCategories();
    categories!.then((data) {
      setState(() {
        filteredCategories = data;
      });
    });
  }

  void filterCategories(String query) {
    if (query.isEmpty) {
      setState(() {
        categories!.then((data) {
          filteredCategories = data;
        });
      });
      return;
    }

    setState(() {
      filteredCategories = filteredCategories?.where((category) {
        final nameMatch =
            category.name.toLowerCase().contains(query.toLowerCase());
        return nameMatch;
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
          "Categories",
          style: GoogleFonts.poppins(
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
              onChanged: filterCategories,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12),
                  child: SvgPicture.asset(
                    'assets/icons/search.svg',
                    width: 20,
                    height: 20,
                    fit: BoxFit.contain,
                  ),
                ),
                hintText: "Search categories...",
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
                  "${filteredCategories?.length ?? 0} results found",
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
              child: FutureBuilder<List<Category>>(
                future: categories,
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
                  } else if (filteredCategories == null ||
                      filteredCategories!.isEmpty) {
                    return const Center(
                      child: Text(
                        "No categories found.",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: filteredCategories!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: screenSize.width * 0.04,
                      mainAxisSpacing: screenSize.width * 0.04,
                      childAspectRatio:
                          0.9, // Adjusted aspect ratio to fit taller cards
                    ),
                    itemBuilder: (context, index) {
                      final category = filteredCategories![index];

                      return CategoryCard(
                        category: category,
                        onTap: () {
                          widget.updateNavBarVisibility(false); // Hide nav bar
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CategoryScreen(
                                      categoryTitle: category.name,
                                      categoryProductsURL: category.url),
                              )).then((_) {
                            widget.updateNavBarVisibility(true); // Show nav bar when back
                          });
                        },
                        index: index,

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
