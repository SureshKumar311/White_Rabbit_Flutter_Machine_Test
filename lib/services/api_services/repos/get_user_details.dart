import 'package:employee/services/api_services/client.dart';
import 'package:get/get.dart';

Future<Response?>? getUserDetailsRepo() async {
  try {
    final Response response =
        await ApiServices().get("http://www.mocky.io/v2/5d565297300000680030a986");
    if (response.isOk) {
      return response;
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}
