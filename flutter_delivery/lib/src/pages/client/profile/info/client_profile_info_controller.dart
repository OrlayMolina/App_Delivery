import 'package:flutter_delivery/src/models/user.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ClientProfileInfoController extends GetxController {

  User user = User.fromJson(GetStorage().read('user'));

  void signOut(){
    GetStorage().remove('user');
    Get.offNamedUntil('/', (route) => false); /// Elimina el historial de pantallas.
  }

  void goToProfileUpdate(){
    Get.offNamed('/client/profile/update');
  }
}