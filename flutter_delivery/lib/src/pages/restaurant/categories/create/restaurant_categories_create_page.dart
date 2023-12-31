import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/pages/restaurant/categories/create/restaurante_categories_create_controller.dart';
import 'package:get/get.dart';

class RestaurantCategoriesCreatePage extends StatelessWidget {

  RestaurantCategoriesCreateController controller = Get.put(RestaurantCategoriesCreateController());

  @override
  Widget build(BuildContext context) {
    /// Scaffold es la maquetación de nuestra aplicación.
    return Scaffold(
      body: Stack(
        /// Llamo el método que carga la imágen principal de la aplicación.
        children: [
          _backgroundCover(context),
          _boxForm(context),
          _textNewCategory(context)
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
      height: MediaQuery.of(context).size.height * 0.44,
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
            _textYourInfo(),
            _textFieldName(),
            _textFieldDescription(),
            _buttonCreate(context)
          ],
        ),
      ),
    );
  }

  /**
   * Campo Textfield para ingresar el nombre del usuario en un formulario.
   */
  Widget _textFieldName(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: controller.nameController,
        keyboardType: TextInputType.text,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
            hintText: 'Nombre',
            /// Propiedad Icon nos habilita una galeria completa de imagenes que podemos utilizar en nuestros componentes.
            prefixIcon: Icon(Icons.category)
        ),
      ),
    );
  }

  /// Campo Textfield para ingresar el apellido del usuario.
  Widget _textFieldDescription(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      child: TextField(
        controller: controller.descriptionController,
        keyboardType: TextInputType.text,
        maxLines: 4,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
            hintText: 'Descripción',
            /// Propiedad Icon nos habilita una galeria completa de imagenes que podemos utilizar en nuestros componentes.
            prefixIcon: Container(
              margin: EdgeInsets.only(bottom: 50),
                child: Icon(Icons.description)
            )
        ),
      ),
    );
  }

  /// Widget que muestra el botón de login.
  Widget _buttonCreate(BuildContext context){
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 2),
      child: ElevatedButton(
          onPressed: () {
            controller.createCategory();
          },
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15)
          ),
          child: Text(
            'CREAR CATEGORIA',
            style: TextStyle(
              color: Colors.black,
            ),
          )
      ),
    );
  }

  Widget _textNewCategory(BuildContext context){
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 15),
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Icon(Icons.category, size: 100),
            Text(
                'NUEVA CATEGORIA',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.black
              ),
            ),
          ],
        )
      ),
    );
  }

  /**
   * Texto auxiliar en la pantalla principal.
   */
  Widget _textYourInfo(){
    return Container(
        margin: EdgeInsets.only(top: 40, bottom: 25),
        child: Text(
          'INGRESA ESTA INFORMACIÓN',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        )
    );
  }
}
