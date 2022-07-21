import 'package:employee/states/user_details_controller.dart';
import 'package:employee/views/screens/user_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Get.put(UserDetailsController()).checkUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Employee"),
          actions: [
            IconButton(
                onPressed: () async {
                  await Get.find<UserDetailsController>().getUserdetails();
                },
                icon: const Icon(Icons.refresh))
          ],
        ),
        body: GetBuilder<UserDetailsController>(builder: (controller) {
          return ListView.builder(
              itemCount: controller.userDetails.length,
              itemBuilder: (_, v) {
                final data = controller.userDetails[v];
                return ListTile(
                  title: Text(data.name ?? ""),
                  subtitle: Text(data.company?.name ?? ""),
                  leading: Image.network(
                    data.profileImage ??
                        "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
                  ),
                  onTap: () async {
                    Get.to(() => UserDetailsScreen(userData: data));
                  },
                );
              });
        }));
  }
}
