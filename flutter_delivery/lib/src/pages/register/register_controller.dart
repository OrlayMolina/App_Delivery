import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController{

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void register(){
    String email = emailController.text.trim();
    String name = nameController.text;
    String lastname = lastnameController.text;
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    print('Email ${email}');
    print('Password ${password}');

    if(isValidForm(email, name, lastname, phone, password, confirmPassword)){
      Get.snackbar('Datos validos', 'Se puede enviar la petición POST para logear al usuario.');
    }
  }

  bool isValidForm(
      String email,
      String name,
      String lastname,
      String phone,
      String password,
      String confirmPassword){

    if(email.isEmpty){
      Get.snackbar('Formulario no valido','correo no valido, debes ingresar un correo electrónico.');
      return false;
    }

    if(!GetUtils.isEmail(email)){
      Get.snackbar('Correo no valido','Debe indicar un correo electrónico correcto.');
      return false;
    }

    if(name.isEmpty){
      Get.snackbar('Formulario no valido','Nombre no valido, debes ingresar tu nombre.');
      return false;
    }

    if(lastname.isEmpty){
      Get.snackbar('Formulario no valido','Apellido no valido, debes ingresar tu apellido.');
      return false;
    }

    if(phone.isEmpty){
      Get.snackbar('Formulario no valido','Número celular no valido, debes ingresar tu número.');
      return false;
    }

    if(password.isEmpty){
      Get.snackbar('Formulario no valido','Contraseña no valida, debes ingresar un contraseña.');
      return false;
    }

    if(confirmPassword.isEmpty){
      Get.snackbar('Formulario no valido','Debes confirmar tu contraseña.');
      return false;
    }

    if(confirmPassword != password){
      Get.snackbar('Formulario no valido','Las contraseñas deben ser iguales.');
      return false;
    }

    return true;
  }
}