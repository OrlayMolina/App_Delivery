import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    /// Scaffold es la maquetación de nuestra aplicación.
    return Scaffold(
      /// El Stack nos permite dar un posicionamiento a diferentes elementos o contenedores.
      body: Stack(
        /// Llamo el método que carga la imágen principal de la aplicación.
        children: [
          /// Utilizamos la 'etiqueta' Column para poder posicionar el nombre de nuestra aplicación por
          /// debajo de la imágen de la app.
          Column(
            children: [
              _imageCover(),
              _textAppName()
            ],
          )
        ],
      ),
    );
  }

  /// Método que monstrará el nombre de la aplicación.
  Widget _textAppName(){
    return const Text(
        'DELIVERY MYSQL'
    );
  }

  /// Cada vez que coloco un _ antes del nombre del método indica que ese método sera PRIVATE.
  Widget _imageCover(){
    return Image.asset('assets/img/delivery.png',
    width: 130,
    height: 130,
    );
  }
}
