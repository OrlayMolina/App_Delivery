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
            'Selecciona el rol',
          style: TextStyle(
            color: Colors.black
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.17),
        child: ListView(
          children: controller.user.roles != null ? controller.user.roles!.map((Rol rol) {
            return _cardRol(rol);
          }).toList() : [],
        ),
      ),
    );
  }

  Widget _cardRol(Rol rol) {
    return GestureDetector(
      onTap: () => controller.goToPageRol(rol),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 15),
            height: 100,
            child: FadeInImage(
              image: NetworkImage(rol.image!),
              fit: BoxFit.contain,
              fadeInDuration: Duration(milliseconds: 50),
              placeholder: AssetImage('assets/img/no-image.png'),
            ),
          ),
          Text(
            rol.name ?? '',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black
            ),
          )
        ],
      ),
    );
  }
}


