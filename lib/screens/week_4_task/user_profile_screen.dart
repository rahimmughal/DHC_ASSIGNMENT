import 'package:dhc_assignment/model/week_4_models/users_resopnse_model.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatefulWidget {
  final UsersResponseModel? user;
  const UserProfileScreen({super.key, this.user});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Profile"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=${widget.user?.id}"),
            ),
            SizedBox(height: 10),
            Text(
              widget.user?.name ?? "Unknown",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              widget.user?.email ?? "Unknown",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 5),
            Text(
              widget.user?.phone ?? "Unknown",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 5),
            Text(
              widget.user?.company?.name ?? "Unknown",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 5),
            Text(
              widget.user?.username ?? "Unknown",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 5),
            Text(
              widget.user?.address?.city ?? "Unknown",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      )
    );
  }
}