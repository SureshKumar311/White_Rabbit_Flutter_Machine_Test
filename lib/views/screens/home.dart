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
  bool isSearch = false;
  late UserDetailsController userDetailscontroller;

  @override
  void initState() {
    userDetailscontroller = Get.put(UserDetailsController())..checkUserData();
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
                Get.showSnackbar(const GetSnackBar(
                  title: 'Processing',
                  message: 'Refreshing Employee data',
                  duration: Duration(seconds: 2),
                ));
                await userDetailscontroller.getUserdetails();
              },
              icon: const Icon(Icons.refresh),
            ),
            IconButton(
              onPressed: () async {
                setState(() {
                  isSearch = !isSearch;
                });

                if (!isSearch) {
                  userDetailscontroller.userDetailsSearch.clear();
                }
              },
              icon: Icon(
                isSearch ? Icons.search_off : Icons.search,
              ),
            ),
          ],
        ),
        body: GetBuilder<UserDetailsController>(
            init: userDetailscontroller,
            builder: (controller) {
              return Column(
                children: [
                  if (isSearch)
                    TextFormField(
                      onChanged: (value) {
                        try {
                          final searchData = userDetailscontroller.userDetails
                              .where(
                                (element) =>
                                    element.name!
                                        .toLowerCase()
                                        .contains(value.toLowerCase()) ||
                                    element.email!
                                        .toLowerCase()
                                        .contains(value.toLowerCase()),
                              )
                              .toList();

                          userDetailscontroller.userDetailsSearch.clear();
                          userDetailscontroller.userDetailsSearch.addAll(searchData);
                          userDetailscontroller.update();
                        } catch (e) {
                          userDetailscontroller.userDetailsSearch.clear();
                          userDetailscontroller.update();
                        }
                      },
                    ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: !isSearch
                            ? controller.userDetails.length
                            : controller.userDetailsSearch.length,
                        itemBuilder: (_, v) {
                          final data = !isSearch
                              ? controller.userDetails[v]
                              : controller.userDetailsSearch[v];
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
                        }),
                  ),
                ],
              );
            }));
  }
}
