import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void goToRegisterPage(){
    Get.toNamed('/register');
  }

  void login(){
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    print('Email ${email}');
    print('Password ${password}');
    
    if(isValidForm(email, password)){
      Get.snackbar('Datos validos', 'Se puede enviar la petición POST para logear al usuario.');
    }
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