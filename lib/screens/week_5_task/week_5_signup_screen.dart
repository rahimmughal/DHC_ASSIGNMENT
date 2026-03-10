import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhc_assignment/utils/app_colors/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Week5SignupScreen extends StatefulWidget {
  const Week5SignupScreen({super.key});

  @override
  State<Week5SignupScreen> createState() => _Week5SignupScreenState();
}

class _Week5SignupScreenState extends State<Week5SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool _isObsecure = true;
  bool _isConfirmObsecure = true;
  bool _isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _signup() async {
    if (_isLoading) return;
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    FocusScope.of(context).unfocus();
    setState(() => _isLoading = true);

    UserCredential? credential;

    try {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      final name = nameController.text.trim();

      credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user == null) {
        throw FirebaseAuthException(code: 'user-null', message: 'User is null after signup.');
      }

      await FirebaseFirestore.instance.collection('users').doc(user.uid).set(
        {
          'name': name,
          'email': email,
          'uid': user.uid,
          'createdAt': FieldValue.serverTimestamp(),
        },
        SetOptions(merge: true),
      );

      if (!mounted) return;
      Navigator.pop(context); // back to login
    } on FirebaseAuthException catch (e) {
      final msg = _authErrorMessage(e);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    } on FirebaseException catch (e) {
      final msg = _firestoreErrorMessage(e);

      // rollback
      try {
        await credential?.user?.delete();
      } catch (_) {}

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    } catch (_) {
      try {
        await credential?.user?.delete();
      } catch (_) {}

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Something went wrong. Try again.")),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  String _authErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return "This email is already registered.";
      case 'invalid-email':
        return "Invalid email address.";
      case 'weak-password':
        return "Password is too weak (min 6 characters).";
      case 'operation-not-allowed':
        return "Email/Password sign up is not enabled in Firebase.";
      case 'network-request-failed':
        return "Network error. Check your internet connection.";
      default:
        return e.message ?? "Signup failed. Please try again.";
    }
  }

  String _firestoreErrorMessage(FirebaseException e) {
    switch (e.code) {
      case 'permission-denied':
        return "Permission denied. Check Firestore rules.";
      case 'unavailable':
        return "Firestore unavailable. Check internet or try again.";
      default:
        return e.message ?? "Failed to save profile. Try again.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: AppColors.backgroundColor),
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                        "Sign Up",
                        style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.kWhite,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Create your account",
                        style: GoogleFonts.poppins(
                          color: AppColors.kWhite.withValues(alpha: 0.6),
                        ),
                      ),
                      const SizedBox(height: 25),

                      // Name
                      TextFormField(
                        controller: nameController,
                        style: GoogleFonts.poppins(color: AppColors.kWhite),
                        cursorColor: AppColors.kWhite,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person),
                          label: const Text("Full Name", style: TextStyle(color: AppColors.kWhite)),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                        ),
                        validator: (value) {
                          final v = (value ?? "").trim();
                          if (v.isEmpty) return "Full Name required";
                          return null;
                        },
                      ),

                      const SizedBox(height: 15),

                      // Email
                      TextFormField(
                        controller: emailController,
                        style: GoogleFonts.poppins(color: AppColors.kWhite),
                        cursorColor: AppColors.kWhite,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email),
                          label: const Text("Email", style: TextStyle(color: AppColors.kWhite)),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                        ),
                        validator: (value) {
                          final v = (value ?? "").trim();
                          if (v.isEmpty) return "Email required";
                          if (!v.contains("@")) return "Enter valid email";
                          return null;
                        },
                      ),

                      const SizedBox(height: 15),

                      // Password
                      TextFormField(
                        controller: passwordController,
                        obscureText: _isObsecure,
                        cursorColor: AppColors.kWhite,
                        style: GoogleFonts.poppins(color: AppColors.kWhite),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          label: const Text("Password", style: TextStyle(color: AppColors.kWhite)),
                          suffixIcon: InkWell(
                            onTap: () => setState(() => _isObsecure = !_isObsecure),
                            child: Icon(
                              _isObsecure ? Icons.visibility_off : Icons.visibility,
                              color: AppColors.kWhite.withValues(alpha: 0.6),
                              size: 18,
                            ),
                          ),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                        ),
                        validator: (value) {
                          final v = (value ?? "");
                          if (v.isEmpty) return "Password required";
                          if (v.length < 6) return "Minimum 6 characters";
                          return null;
                        },
                      ),

                      const SizedBox(height: 15),

                      // Confirm Password
                      TextFormField(
                        controller: confirmPasswordController,
                        obscureText: _isConfirmObsecure,
                        cursorColor: AppColors.kWhite,
                        style: GoogleFonts.poppins(color: AppColors.kWhite),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock_outline),
                          label: const Text("Confirm Password", style: TextStyle(color: AppColors.kWhite)),
                          suffixIcon: InkWell(
                            onTap: () => setState(() => _isConfirmObsecure = !_isConfirmObsecure),
                            child: Icon(
                              _isConfirmObsecure ? Icons.visibility_off : Icons.visibility,
                              color: AppColors.kWhite.withValues(alpha: 0.6),
                              size: 18,
                            ),
                          ),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                        ),
                        validator: (value) {
                          final v = (value ?? "");
                          if (v.isEmpty) return "Confirm your password";
                          if (v != passwordController.text) return "Passwords do not match";
                          return null;
                        },
                      ),

                      const SizedBox(height: 25),

                      // SIGN UP
                      TextButton(
                        onPressed: _isLoading ? null : _signup,
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
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                )
                              : Text(
                                  "SIGN UP",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.kBlack,
                                  ),
                                ),
                        ),
                      ),

                      // Back to login
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          "Already have an account? Login",
                          style: GoogleFonts.poppins(
                            color: AppColors.kWhite.withValues(alpha: 0.8),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}