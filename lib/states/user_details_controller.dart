import 'package:employee/models/user_details_model.dart';
import 'package:employee/services/api_services/repos/get_user_details.dart';
import 'package:employee/services/storage_services.dart';
import 'package:get/get.dart';

class UserDetailsController extends GetxController {
  List<UserDetailsModel> userDetails = [];
  List<UserDetailsModel> userDetailsSearch = [];

  Future checkUserData() async {
    final userLocalData = LocalStorage.box.read<List>(LocalStorage.userData);
    if (userLocalData == null || userLocalData.isNotEmpty) {
      await getUserdetails();
      await LocalStorage.box.write(
        LocalStorage.userData,
        userDetails.map((e) => e.toJson()).toList(),
      );
    } else {
      userDetails.clear();
      for (var element in userLocalData) {
        userDetails.add(UserDetailsModel.fromJson(element));
      }
      update();
    }
  }

  Future getUserdetails() async {
    final data = await getUserDetailsRepo();
    userDetails.clear();
    for (var element in List.from(data?.body ?? [])) {
      userDetails.add(UserDetailsModel.fromJson(element));
    }
    update();
  }
}
