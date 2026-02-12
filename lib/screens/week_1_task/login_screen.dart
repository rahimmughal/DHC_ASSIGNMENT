import 'package:dhc_assignment/screens/home_screen.dart';
import 'package:dhc_assignment/screens/week_1_task/week_1_home_screen.dart';
import 'package:dhc_assignment/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  final bool isBackStackEmpty;
  const LoginScreen({super.key, this.isBackStackEmpty = false});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isObsecure = true;

  @override
  Widget build(BuildContext context) {
    return PopScope( 
      canPop: !widget.isBackStackEmpty,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            color: AppColors.backgroundColor
          ),
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
                            color: AppColors.kWhite
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
                
                        TextFormField(
                          controller: emailController,
                          style: GoogleFonts.poppins(
                            color: AppColors.kWhite
                          ),
                          cursorColor: AppColors.kWhite,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.email),
                            label: Text("Email", style: TextStyle(color: AppColors.kWhite),),
                            labelStyle: GoogleFonts.poppins(),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
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
                
                        TextFormField(
                          controller: passwordController,
                          obscureText: _isObsecure,
                          cursorColor: AppColors.kWhite,
                          style: GoogleFonts.poppins(
                            color: AppColors.kWhite
                          ),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            label: Text("Password", style: TextStyle(color: AppColors.kWhite),),
                            labelStyle: GoogleFonts.poppins(),
                            suffixIcon: InkWell(
                              onTap: (){
                                setState(() {
                                  _isObsecure = !_isObsecure;
                                });
                              },
                              child: Icon((_isObsecure)?Icons.visibility_off: Icons.visibility, color: AppColors.kWhite.withValues(alpha: 0.6), size: 18,)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
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
      
                        TextButton(onPressed: (){
                          if (_formKey.currentState!.validate()) {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Week1HomeScreen(),
                                ),
                                (route) => false,
                              );
                            }
                        }, child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                              "LOGIN",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.kBlack
                              ),
                            ),
                        ),),
                        if(widget.isBackStackEmpty)TextButton(
                          onPressed: (){
                         Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
                                ),
                                (route) => false,
                              );
                        }, child: Container(
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
                                color: AppColors.kBlack
                              ),
                            ),
                        ),),
                        if(widget.isBackStackEmpty == false)TextButton(
                          onPressed: (){
                         Navigator.pop(context);
                        }, child: Container(
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
                                color: AppColors.kBlack
                              ),
                            ),
                        ),),
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
}
