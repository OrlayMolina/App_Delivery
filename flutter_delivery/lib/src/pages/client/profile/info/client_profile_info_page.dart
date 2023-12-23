import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/pages/client/profile/info/client_profile_info_controller.dart';
import 'package:get/get.dart';

class ClientProfileInfoPage extends StatelessWidget {

  ClientProfileInfoController controller = Get.put(ClientProfileInfoController());

  @override
  Widget build(BuildContext context) {
    /// Scaffold es la maquetación de nuestra aplicación.
    return Scaffold(
      body: Stack(
        /// Llamo el método que carga la imágen principal de la aplicación.
        children: [
          _backgroundCover(context),
          _boxForm(context),
          _imageUser(context),
          _buttonSignOut()
        ],
      ),
    );
  }

  /// Color amarillo de fondo de la pantalla de inicio.
  Widget _backgroundCover(BuildContext context){
    return Container(
      /// Propiedad double.infinity para cubrir todo el fondo completo.
      width: double.infinity,
      /// Recibe por parámetro el contexto (tamaño de pantalla, entre otros) para realizar el cálculo a tráves de porcenje
      /// de cuánto debería ocupar el color amarillo de fondo.
      height: MediaQuery.of(context).size.height * 0.35,
      color: Colors.amber,
    );
  }

  /// Método que construye un componente frame en donde el usuario se logeará.
  Widget _boxForm(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height * 0.38,
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3, left: 50, right: 50),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black54,
                blurRadius: 15,
                offset: Offset(0, 0.75)
            )
          ]
      ),
      /// SingleChildScrollView arregla un problema de overflow o sobreposición en los textFileds.
      child: SingleChildScrollView(
        child: Column(
          children: [
            _textName(),
            _textEmail(),
            _textPhone(),
            _buttonUpdate(context)
          ],
        ),
      ),
    );
  }

  Widget _buttonSignOut(){
    return SafeArea(
        child: Container(
          margin: EdgeInsets.only(right: 10),
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: () => controller.signOut(),
            icon: Icon(
              Icons.power_settings_new,
              color: Colors.white,
              size: 30,
            ),
          ),
        )
    );
  }

  /// Widget que muestra el botón de login.
  Widget _buttonUpdate(BuildContext context){
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
      child: ElevatedButton(
          onPressed: () => controller.goToProfileUpdate(),
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15)
          ),
          child: Text(
            'ACTUALIZAR DATOS',
            style: TextStyle(
              color: Colors.black,
            ),
          )
      ),
    );
  }

  Widget _imageUser(BuildContext context){
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 35),
        alignment: Alignment.topCenter,
        child:CircleAvatar(
          /// NULL SAFETY
          backgroundImage: controller.user.image != null
              ? NetworkImage(controller.user.image!)
              : AssetImage('assets/img/user_profile.png') as ImageProvider,
          radius: 60,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }

  /**
   * Texto auxiliar en la pantalla principal.
   */
  Widget _textName(){
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: ListTile(
        leading: Icon(
            Icons.person
        ),
        title: Text('${controller.user.name ?? ''} ${controller.user.lastname ?? ''}'),
        subtitle: Text('Nombre del usuario'),
      ),
    );
  }

  /**
   * Texto email.
   */
  Widget _textEmail(){
    return ListTile(
      leading: Icon(Icons.email),
      title: Text(controller.user.email ?? ''),
      subtitle: Text('Email'),
    );
  }

  /**
   * Texto phone.
   */
  Widget _textPhone(){
    return ListTile(
      leading: Icon(Icons.phone),
      title: Text(controller.user.phone ?? ''),
      subtitle: Text('Teléfono'),
    );
  }
}
