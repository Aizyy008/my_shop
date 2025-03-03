import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_store/providers/wishlist_provider.dart';
import 'package:my_store/utilities/color_converter.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:my_store/screens/account_screen.dart';
import 'package:my_store/screens/categories_screen.dart';
import 'package:my_store/screens/favorites_screen.dart';
import 'package:my_store/screens/products_screen.dart';
import 'package:my_store/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
providers: [
  ChangeNotifierProvider(create: (_) => WishlistProvider())
],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Store',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PersistentTabController _controller = PersistentTabController(initialIndex: 0);
  bool _isNavBarVisible = true;
  void _updateNavBarVisibility(bool isVisible) {
    setState(() {
      _isNavBarVisible = isVisible;
    });
  }
  List<Widget> _buildScreens() {
    return [
      ProductsScreen(updateNavBarVisibility: _updateNavBarVisibility),
      CategoriesScreen(updateNavBarVisibility: _updateNavBarVisibility),
      const FavoritesScreen(),
      const AccountScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Padding(
          padding: EdgeInsets.only(top: 8.0), // Adding top padding
          child: Icon(Icons.shopping_bag_outlined),
        ),
        title: "Products",
        textStyle: GoogleFonts.poppins(
          fontSize: 10,
          fontWeight: FontWeight.w400,
          color: ColorConverter.fromHex("#F2F2F2")
        ),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: const Padding(
          padding: EdgeInsets.only(top: 8.0), // Adding top padding
          child: Icon(Icons.category_outlined),
        ),
        title: "Categories",
        textStyle: GoogleFonts.poppins(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: ColorConverter.fromHex("#F2F2F2")
        ),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: const Padding(
          padding: EdgeInsets.only(top: 8.0), // Adding top padding
          child: Icon(Icons.favorite_border_outlined),
        ),
        title: "Favorites",
        textStyle: GoogleFonts.poppins(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: ColorConverter.fromHex("#F2F2F2")
        ),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white,
      ),
      PersistentBottomNavBarItem(
        icon: const Padding(
          padding: EdgeInsets.only(top: 8.0), // Adding top padding
          child: Icon(Icons.person_outline_sharp),
        ),
        title: "Account",
        textStyle: GoogleFonts.poppins(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: ColorConverter.fromHex("#F2F2F2")
        ),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white,
      ),
    ];
  }


  @override
  Widget build(BuildContext context) {

    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      backgroundColor: Colors.black,
      navBarStyle: NavBarStyle.style6,
      isVisible: _isNavBarVisible,
    );
  }
}
