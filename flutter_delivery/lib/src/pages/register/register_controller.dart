import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/models/response_api.dart';
import 'package:flutter_delivery/src/providers/users_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

import '../../models/user.dart';

class RegisterController extends GetxController{

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  ImagePicker picker = ImagePicker();
  File? imageFile;

  void register(BuildContext context) async{
    String email = emailController.text.trim();
    String name = nameController.text;
    String lastname = lastnameController.text;
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    print('Email ${email}');
    print('Password ${password}');

    if(isValidForm(email, name, lastname, phone, password, confirmPassword)){

      ProgressDialog progressDialog = ProgressDialog(context: context);
      progressDialog.show(max: 100, msg: 'Registrando datos ...');

      User user = User(
        email: email,
        name: name,
        lastname: lastname,
        phone: phone,
        password: password
      );

      Stream stream = await usersProvider.createWithImage(user, imageFile!);
      stream.listen((res) {

        progressDialog.close();
        ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));

        if(responseApi.success == true){
          GetStorage().write('user', responseApi.data); /// Datos del usuario en sesión
          goToHomePage();
        }else {
          Get.snackbar('Registro fallido', responseApi.message ?? '');
        }

      });
    }
  }

  void goToHomePage(){
    Get.offNamedUntil('/home', (route) => false);
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

    if(imageFile == null){
      Get.snackbar('Formulario no valido','Debes seleccionar una imágen.');
      return false;
    }

    return true;
  }

  Future selectImage(ImageSource imageSource) async {
    XFile? image = await picker.pickImage(source: imageSource);
    if(image != null){
      imageFile = File(image.path);
      update();
    }
  }

  void showAlertDialog(BuildContext context){
    Widget galleryButton = ElevatedButton(
        onPressed: () {
          Get.back();
          selectImage(ImageSource.gallery);
        },
        child: Text(
          'GALERIA',
          style: TextStyle(
            color: Colors.black
          ),
        )
    );

    Widget cameraButton = ElevatedButton(
        onPressed: () {
          Get.back();
          selectImage(ImageSource.camera);
        },
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