import 'package:dhc_assignment/screens/week_5_task/week_5_login_screen.dart';
import 'package:dhc_assignment/utils/app_colors/app_colors.dart';
import 'package:dhc_assignment/widgets/app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Week5HomeScreen extends StatelessWidget {
  const Week5HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(title: "Home"),
      body: PopScope(
        canPop: false,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "Welcome to the home screen",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.kWhite,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              InkWell(
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const Week5LoginScreen(isBackStackEmpty: true),
                    ),
                    (route) => false,
                  );
                },
                child: Container(
                  width: 180,
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
                  decoration: BoxDecoration(
                    color: AppColors.kWhite.withValues(alpha: .8),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    "Log out",
                    style:
                        TextStyle(color: AppColors.backgroundColor, fontSize: 16),
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