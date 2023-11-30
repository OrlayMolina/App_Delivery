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
          _imageCover()
        ],
      ),
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
