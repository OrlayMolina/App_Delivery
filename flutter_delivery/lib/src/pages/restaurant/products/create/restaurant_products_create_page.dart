import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/models/category.dart';
import 'package:flutter_delivery/src/pages/restaurant/products/create/restaurante_products_create_controller.dart';
import 'package:get/get.dart';

class RestaurantProductsCreatePage extends StatelessWidget {

  RestaurantProductsCreateController controller = Get.put(RestaurantProductsCreateController());

  @override
  Widget build(BuildContext context) {
    /// Scaffold es la maquetación de nuestra aplicación.
    return Obx(() => Scaffold(
      body: Stack(
        /// Llamo el método que carga la imágen principal de la aplicación.
        children: [
          _backgroundCover(context),
          _boxForm(context),
          _textNewCategory(context)
        ],
      )),
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
      height: MediaQuery.of(context).size.height * 0.7,
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.17, left: 50, right: 50),
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
            _textFieldPrice(),
            _dropDownCategories(controller.categories),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GetBuilder<RestaurantProductsCreateController>(
                      builder: (value) => _cardImage(context, controller.imageFile1, 1),
                  ),
                  SizedBox(width: 5),
                  GetBuilder<RestaurantProductsCreateController>(
                    builder: (value) => _cardImage(context, controller.imageFile2, 2),
                  ),
                  SizedBox(width: 5),
                  GetBuilder<RestaurantProductsCreateController>(
                    builder: (value) => _cardImage(context, controller.imageFile3, 3),
                  ),
                ],
              ),
            ),
            _buttonCreate(context)
          ],
        ),
      ),
    );
  }

  Widget _dropDownCategories(List<Category> categories) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      margin: EdgeInsets.only(top: 15),
      child: DropdownButton(
        underline: Container(
          alignment: Alignment.centerRight,
          child: Icon(
            Icons.arrow_drop_down_circle,
            color: Colors.amber,
          ),
        ),
        elevation: 3,
        isExpanded: true,
        hint: Text(
          'Seleccione una categoria',
          style: TextStyle(
            fontSize: 17
          ),
        ),
        items: _dropDownItems(categories),
        value: controller.idCategory,
        onChanged: (option) {
          print('Opcion seleccionada ${option}');
          controller.idCategory = option.toString();
        },
      ),
    );
  }

  /// Método que consulta las categorias obtenidas para posteriormente poder ser mostradas en pantalla.
  List<DropdownMenuItem<String?>> _dropDownItems(List<Category> categories){
    List<DropdownMenuItem<String>> list = [];
    categories.forEach((category) {
      list.add(DropdownMenuItem(
        child: Text(category.name ?? ''),
        value: category.id,
      ));
    });

    return list;
  }

  Widget _cardImage(BuildContext context, File? imageFile, int numberFile){
    return GestureDetector(
        onTap: () => controller.showAlertDialog(context, numberFile),
        child: Card(
          elevation: 3,
          child: Container(
            padding: EdgeInsets.all(4),
            height: 68,
            color: Colors.white,
            width: MediaQuery.of(context).size.width * 0.16,
            child: imageFile != null
                ? Image.file(
              imageFile,
              fit: BoxFit.cover,
            )
                : Image(image: AssetImage('assets/img/cover_image.png')),
          ),
        )
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

  /**
   * Campo Textfield para ingresar el precio del producto.
   */
  Widget _textFieldPrice(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: controller.priceController,
        keyboardType: TextInputType.number,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
            hintText: 'Precio',
            /// Propiedad Icon nos habilita una galeria completa de imagenes que podemos utilizar en nuestros componentes.
            prefixIcon: Icon(Icons.attach_money)
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
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      child: ElevatedButton(
          onPressed: () {
            controller.createCategory();
          },
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 1)
          ),
          child: Text(
            'CREAR PRODUCTO',
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
        margin: EdgeInsets.only(top: 37),
        alignment: Alignment.topCenter,
        child: Text(
          'NUEVO PRODUCTO',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.black
          ),
        ),
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
