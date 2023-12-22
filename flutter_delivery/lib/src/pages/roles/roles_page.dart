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
        title: Text('Seleccionar el rol'),
      ),
      body: ListView(
        children: controller.user.roles != null ? controller.user.roles!.map((Rol rol) {
          return Text(rol.name ?? '');
        }).toList() : [],
      ),
    );
  }
}


