import 'package:employee/models/user_details_model.dart';
import 'package:flutter/material.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({Key? key, required this.userData}) : super(key: key);
  final UserDetailsModel userData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employee Details "),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Image.network(
              userData.profileImage ??
                  "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
            ),
          ),
          customRow("User Name", userData.username),
          customRow("Name,", userData.name),
          customRow("Email address", userData.email),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Text(
              'Address :',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                customRow("Street", userData.address?.street),
                customRow("City", userData.address?.city),
                customRow("Zipcode", userData.address?.zipcode),
                customRow("Phone,", userData.phone),
                customRow("Website", userData.website),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Text(
              'Company Details :',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                customRow("Name", userData.company?.name),
                customRow("Bs", userData.company?.bs),
                customRow("CatchPhrase", userData.company?.catchPhrase),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget customRow(String? str1, String? str2) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        children: [
          Text(
            str1 ?? 'No data',
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          const Text(' :'),
          const SizedBox(width: 10),
          Text(str2 ?? 'No data'),
        ],
      ),
    );
  }
}
