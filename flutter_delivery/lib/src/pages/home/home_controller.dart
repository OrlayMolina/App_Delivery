import 'package:flutter_delivery/src/models/user.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController{

  /// la dependencia GetStorage en su método read recibe la llave definida en el loginController.
  User user = User.fromJson(GetStorage().read('user') ?? {});

  HomeController(){
    print('USUARIO DE SESIÓN: ${user.toJson()}');
  }

  void signOut(){
    GetStorage().remove('user');
    Get.offNamedUntil('/', (route) => false); /// Elimina el historial de pantallas.
  }
}