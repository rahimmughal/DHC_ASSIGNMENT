import 'package:dhc_assignment/screens/home_screen.dart';
import 'package:dhc_assignment/screens/week_5_task/week_5_profile_screen.dart';
import 'package:dhc_assignment/screens/week_5_task/week_5_signup_screen.dart';
import 'package:dhc_assignment/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Week5LoginScreen extends StatefulWidget {
  final bool isBackStackEmpty;
  const Week5LoginScreen({super.key, this.isBackStackEmpty = false});

  @override
  State<Week5LoginScreen> createState() => _Week5LoginScreenState();
}

class _Week5LoginScreenState extends State<Week5LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isObsecure = true;
  bool _isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !widget.isBackStackEmpty,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(color: AppColors.backgroundColor),
          child: Center(
            child: SingleChildScrollView(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: AppColors.lightBlackBackgroundColor,
                elevation: 3,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Login",
                          style: GoogleFonts.poppins(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.kWhite,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Login to your account",
                          style: GoogleFonts.poppins(
                            color: AppColors.kWhite.withValues(alpha: 0.6),
                          ),
                        ),
                        const SizedBox(height: 25),

                        // EMAIL
                        TextFormField(
                          controller: emailController,
                          style: GoogleFonts.poppins(color: AppColors.kWhite),
                          cursorColor: AppColors.kWhite,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.email),
                            label: const Text(
                              "Email",
                              style: TextStyle(color: AppColors.kWhite),
                            ),
                            labelStyle: GoogleFonts.poppins(),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email required";
                            }
                            if (!value.contains("@")) {
                              return "Enter valid email";
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 15),

                        // PASSWORD
                        TextFormField(
                          controller: passwordController,
                          obscureText: _isObsecure,
                          cursorColor: AppColors.kWhite,
                          style: GoogleFonts.poppins(color: AppColors.kWhite),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            label: const Text(
                              "Password",
                              style: TextStyle(color: AppColors.kWhite),
                            ),
                            labelStyle: GoogleFonts.poppins(),
                            suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  _isObsecure = !_isObsecure;
                                });
                              },
                              child: Icon(
                                (_isObsecure)
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: AppColors.kWhite.withValues(alpha: 0.6),
                                size: 18,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Password required";
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 25),

                        // LOGIN BUTTON (FIXED)
                        TextButton(
                          onPressed: _isLoading ? null : _login,
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: _isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    "LOGIN",
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.kBlack,
                                    ),
                                  ),
                          ),
                        ),

                        // SIGNUP BUTTON
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Week5SignupScreen(),
                              ),
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              "SIGN UP",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.kBlack,
                              ),
                            ),
                          ),
                        ),

                        if (widget.isBackStackEmpty)
                          TextButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
                                ),
                                (route) => false,
                              );
                            },
                            child: _returnBtn(),
                          ),

                        if (!widget.isBackStackEmpty)
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: _returnBtn(),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _returnBtn() {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        "Return To Main Dashboard",
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.kBlack,
        ),
      ),
    );
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (!mounted) return;

      // ✅ AFTER LOGIN GO TO PROFILE SCREEN
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const Week5ProfileScreen()),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      String msg = "Login failed";

      if (e.code == 'user-not-found') {
        msg = "No user found for this email.";
      } else if (e.code == 'wrong-password') {
        msg = "Wrong password.";
      } else if (e.code == 'invalid-email') {
        msg = "Invalid email address.";
      } else if (e.code == 'user-disabled') {
        msg = "This user account is disabled.";
      } else if (e.code == 'too-many-requests') {
        msg = "Too many attempts. Try again later.";
      } else if (e.code == 'invalid-credential') {
        msg = "Invalid login credentials.";
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Something went wrong. Try again.")),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }
}