import 'package:dhc_assignment/utils/app_colors/app_colors.dart';
import 'package:dhc_assignment/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen>
    with WidgetsBindingObserver {

  int count = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    loadCounter();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
    saveCounter();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      saveCounter();
    }
  }

  Future<void> loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      count = prefs.getInt('counter') ?? 0;
    });
  }

  Future<void> saveCounter() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counter', count);
  }

  void increase() {
    setState(() {
      count++;
    });
  }

  void decrease() {
    if (count > 0) {
      setState(() {
        count--;
      });
    }
  }

  void reset() {
    setState(() {
      count = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(
        title: "Smart Counter",
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Column(
        children: [
          SizedBox(height: 30,),
          const Text(
                    "Your Count",
                    style: TextStyle(
                      fontSize: 32,
                      color: AppColors.kWhite,
                    ),
                  ),
          
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        count.toString(),
                        style: const TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
          
                  const SizedBox(height: 25),
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: AppColors.lightBlackBackgroundColor,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                    
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildActionButton(
                      icon: Icons.remove,
                      onPressed: decrease,
                      buttonColor: AppColors.kRed
                    ),
                    const SizedBox(width: 20),
                    _buildActionButton(
                      icon: Icons.add,
                      onPressed: increase,
                      buttonColor: AppColors.kGreen
                    ),
                  ],
                ),
                    
                const SizedBox(height: 20),
                    
                TextButton.icon(
                  onPressed: reset,
                  icon: const Icon(Icons.refresh),
                  label: Text("Reset", style: TextStyle(color: AppColors.kWhite) ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback? onPressed,
    required Color buttonColor,
  }) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          iconColor: AppColors.kWhite,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          padding: const EdgeInsets.all(18),
          elevation: 4,
        ),
        child: Icon(icon, size: 28),
      ),
    );
  }
}
