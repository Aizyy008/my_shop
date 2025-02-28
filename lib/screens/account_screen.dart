import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_store/constants/settings_rows.dart';
import 'package:my_store/utilities/color_converter.dart';
import 'package:my_store/utilities/screen_utils.dart';


class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {

  @override
  Widget build(BuildContext context) {
    final screenSize = ScreenUtils(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Mitt konto",
          style: GoogleFonts.playfairDisplay(
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
            Container(
              padding: EdgeInsets.all(screenSize.width * 0.04),
              height: screenSize.height * 0.15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black,
              ),
              child: Row(
                children: [
                  SizedBox(width: screenSize.width * 0.02),
                  const CircleAvatar(
                    radius: 30, // Slightly larger for better visibility
                    backgroundImage: AssetImage('images/profile.jpg'),
                  ),
                  SizedBox(width: screenSize.width * 0.07), // Space between avatar and text
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Aizan Ahmed",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: ColorConverter.fromHex("#F2F2F2"),
                          ),
                        ),
                        SizedBox(height: screenSize.height * 0.004), // Space between text elements
                        Text(
                          "malikaizan198@gmail.com",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: ColorConverter.fromHex("#F2F2F2"),
                          ),
                        ),
                        Text(
                          "+92306-6819212",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: ColorConverter.fromHex("#F2F2F2"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenSize.height * 0.05),
            Expanded(
              child: ListView.builder(
                itemCount: SettingsRows.menuItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: SvgPicture.asset(
                      SettingsRows.menuItems[index]["icon"]!,
                      width: 24,
                      height: 24,
                    ),
                    title: Text(
                      SettingsRows.menuItems[index]["text"]!,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    onTap: () {
                      // Handle menu item tap
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
