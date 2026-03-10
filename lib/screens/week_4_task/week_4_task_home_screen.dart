import 'package:dhc_assignment/data/response_model.dart';
import 'package:dhc_assignment/model/week_4_models/users_resopnse_model.dart';
import 'package:dhc_assignment/repo/week_4_task/user.dart';
import 'package:dhc_assignment/screens/week_4_task/user_profile_screen.dart';
import 'package:dhc_assignment/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class Week4TaskHomeScreen extends StatefulWidget {
  const Week4TaskHomeScreen({super.key});

  @override
  State<Week4TaskHomeScreen> createState() => _Week4TaskHomeScreenState();
}

class _Week4TaskHomeScreenState extends State<Week4TaskHomeScreen> {
  bool isLoading = true;
  String? errorMessage;
  List<UsersResponseModel> users = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final response = await UserRepo().getUsers();
      if(response is SuccessResponse){
        setState(() {
          users = response.data;
          isLoading = false;
        });
      }else{
        setState(() {
          errorMessage = (response as FailureResponse).error;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.message.toString())));
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.lightBlackBackgroundColor,
        title: const Text("Users"),
        titleTextStyle: TextStyle(color: AppColors.kWhite),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(child: Text(errorMessage!))
              : ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return InkWell( 
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserProfileScreen(user: user),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.centerLeft, 
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar( 
                              radius: 30,
                              foregroundImage: NetworkImage("https://i.pravatar.cc/150?img=${user.id}"),
                            ), 
                            SizedBox(width: 10,), 
                            Column(
                              children: [
                                Text(user.name??"--", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 226, 219, 219)),),
                                Text(user.email??"--", style: TextStyle(fontSize: 14, color: const Color.fromARGB(255, 226, 219, 219))),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}