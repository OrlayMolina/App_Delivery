import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/pages/roles/roles_controller.dart';
import 'package:flutter_delivery/src/models/rol.dart';
import 'package:get/get.dart';

class RolesPage extends StatelessWidget {
  RolesController controller = Get.put(RolesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Seleccionar el rol',
          style: TextStyle(
            color: Colors.black
          ),
        ),
      ),
      body: ListView(
        children: controller.user.roles != null ? controller.user.roles!.map((Rol rol) {
          return Text(rol.name ?? '');
        }).toList() : [],
      ),
    );
  }

  Widget _cardRol(Rol rol) {
    return Column(
      children: [
        Container(
          height: 100,
          child: FadeInImage(
            image: NetworkImage(rol.image!),
            fit: BoxFit.contain,
            fadeInDuration: Duration(milliseconds: 50),
            placeholder: AssetImage(''),
          ),
        )
      ],
    );
  }
}


