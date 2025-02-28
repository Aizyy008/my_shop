import "dart:async";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:my_store/utilities/color_converter.dart";
import "package:my_store/main.dart"; // Import HomeScreen

import "../utilities/screen_utils.dart";

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToHomeScreen();
  }

  void navigateToHomeScreen() async {
    Timer(
      const Duration(seconds: 2),
          () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = ScreenUtils(context);
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'images/splash.jpeg',
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.only(top: screenSize.height * 0.1, left: screenSize.width * 0.25),
              child: Text(
                "My Store",
                style: GoogleFonts.playfairDisplay(
                  fontSize: 50,
                  fontWeight: FontWeight.w400,
                  color: ColorConverter.fromHex("#000000"),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: screenSize.height * 0.75),
                child: Column(
                  children: [
                    Text(
                      "Välkommen",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: ColorConverter.fromHex("#FFFFFF"),
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.02),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
                      child: Text(
                        "Hos oss kan du boka tid hos nästan alla Sveriges salonger och mottagningar. Boka frisör, massage, skönhetsbehandlingar, friskvård och mycket mer.",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: ColorConverter.fromHex("#FFFFFF"),
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 5,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
