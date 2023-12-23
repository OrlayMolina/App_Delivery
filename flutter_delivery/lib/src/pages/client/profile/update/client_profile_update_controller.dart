import 'dart:convert';
import 'dart:io';
import 'package:flutter_delivery/src/models/user.dart';
import 'package:flutter_delivery/src/models/response_api.dart';
import 'package:flutter_delivery/src/providers/users_provider.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class ClientProfileUpdateController extends GetxController {

  User user = User.fromJson(GetStorage().read('user'));

  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  ImagePicker picker = ImagePicker();
  File? imageFile;

  UsersProvider usersProvider = UsersProvider();

  ClientProfileUpdateController() {
    nameController.text = user.name ?? '';
    lastnameController.text = user.lastname ?? '';
    phoneController.text = user.phone ?? '';
  }

  void updateInfo(BuildContext context) async{
    String name = nameController.text;
    String lastname = lastnameController.text;
    String phone = phoneController.text.trim();


    if(isValidForm(name, lastname, phone)){

      ProgressDialog progressDialog = ProgressDialog(context: context);
      progressDialog.show(max: 100, msg: 'Actualizando datos ...');

      User myUser = User(
        id: user.id,
        name: name,
        lastname: lastname,
        phone: phone,
      );

      if(imageFile == null){
        ResponseApi responseApi = await usersProvider.update(myUser);
        Get.snackbar('Se actualizó el usuario correctamente', responseApi.message ?? '');
        progressDialog.close();
        if(responseApi.success == true){
          user.name = name;
          user.lastname = lastname;
          user.phone = phone;
          GetStorage().write('user', user);
          print('Response Api Update: ${responseApi.data}');
        }
      }else {
        Stream stream = await usersProvider.updateWithImage(myUser, imageFile!);
        stream.listen((res) {

          progressDialog.close();
          ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
          Get.snackbar('Se actualizó el usuario correctamente', responseApi.message ?? '');
          print('Response Api Update: ${responseApi.data}');

          if(responseApi.success == true){
            user.name = name;
            user.lastname = lastname;
            user.phone = phone;
            user.image = responseApi.data['image'];
            GetStorage().write('user', user);
          }else {
            Get.snackbar('Registro fallido', responseApi.message ?? '');
          }

        });
      }

    }
  }

  bool isValidForm(
      String name,
      String lastname,
      String phone){

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