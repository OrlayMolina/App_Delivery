import 'package:flutter/cupertino.dart';
import 'package:flutter_delivery/src/models/response_api.dart';
import 'package:flutter_delivery/src/providers/users_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  void goToRegisterPage(){
    Get.toNamed('/register');
  }

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    
    if(isValidForm(email, password)){

      ResponseApi responseApi = await usersProvider.login(email, password);

      print('Response Api: ${responseApi.toJson()}');

      if(responseApi.success == true){
        /// Almacenamos los datos del usuario.
        GetStorage().write('user', responseApi.data);
        ///goToHomePage();
        goToRolesPage();
      }else{
        Get.snackbar('Login incorrecto', responseApi.message ?? '');
      }
    }
  }

  void goToHomePage(){
    Get.offNamedUntil('/home', (route) => false);
  }

  void goToRolesPage(){
    Get.offNamedUntil('/roles', (route) => false);
  }

  bool isValidForm(String email, String password){

    if(email.isEmpty){
      Get.snackbar('Formulario no valido','correo no valido, debes ingresar un correo electrónico.');
      return false;
    }

    if(!GetUtils.isEmail(email)){
      Get.snackbar('Correo no valido','Debe indicar un correo electrónico correcto.');
      return false;
    }

    if(password.isEmpty){
      Get.snackbar('Formulario no valido','Contraseña no valida, debes ingresar un contraseña.');
      return false;
    }

    return true;
  }
}