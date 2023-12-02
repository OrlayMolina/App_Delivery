import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/models/user.dart';
import 'package:flutter_delivery/src/providers/users_provider.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController{

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  void register() async{
    String email = emailController.text.trim();
    String name = nameController.text;
    String lastname = lastnameController.text;
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    print('Email ${email}');
    print('Password ${password}');
    print('name ${name}');
    print('lastname ${lastname}');
    print('phone ${phone}');
    print('confirmPassword ${confirmPassword}');

    if(isValidForm(email, name, lastname, phone, password, confirmPassword)){
      print(email);
      print(name);
      print(lastname);
      print(phone);
      print(password);
      print(confirmPassword);
      User user = User(
        email: email,
        name: name,
        lastname: lastname,
        phone: phone,
        password: password
      );

      Response response = await usersProvider.create(user);

      print('RESPONSE: ${response.body}');

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

  void showAlertDialog(BuildContext context){
    Widget galleryButton = ElevatedButton(
        onPressed: () {},
        child: Text(
          'GALERIA',
          style: TextStyle(
            color: Colors.black
          ),
        )
    );

    Widget cameraButton = ElevatedButton(
        onPressed: () {},
        child: Text(
            'CÁMARA',
          style: TextStyle(
            color: Colors.black
          ),
        )
    );

    AlertDialog alertDialog = AlertDialog(
      title: Text(
        'Selecciona una opción',
        style: TextStyle(
          color: Colors.black
        ),
      ),
      actions: [
        galleryButton,
        cameraButton
      ],
    );

    showDialog(context: context, builder: (BuildContext context){
      return alertDialog;
    });
  }
}