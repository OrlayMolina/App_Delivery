import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    /// Scaffold es la maquetación de nuestra aplicación.
    return Scaffold(
      /// Propiedad para ubicar el título al final de la pantalla.
      bottomNavigationBar: Container(
        height: 50,
        child: _textDontHaveAccount(),
      ),
      /// El Stack nos permite dar un posicionamiento a diferentes elementos o contenedores sobreponiendose.
      body: Stack(
        /// Llamo el método que carga la imágen principal de la aplicación.
        children: [
          _backgroundCover(context),
          _boxForm(context),
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

  /// Color amarillo de fondo de la pantalla de inicio.
  Widget _backgroundCover(BuildContext context){
    return Container(
      /// Propiedad double.infinity para cubrir todo el fondo completo.
      width: double.infinity,
      /// Recibe por parámetro el contexto (tamaño de pantalla, entre otros) para realizar el cálculo a tráves de porcenje
      /// de cuánto debería ocupar el color amarillo de fondo.
      height: MediaQuery.of(context).size.height * 0.4,
      color: Colors.amber,
    );
  }

  /// Método que monstrará el nombre de la aplicación.
  Widget _textAppName(){
    return const Text(
      'DELIVERY APP',
      style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black),
    );
  }

  /// Método que construye un componente frame en donde el usuario se logeará.
  Widget _boxForm(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.33, left: 50, right: 50),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black54,
            blurRadius: 15,
            offset: Offset(0, 0.75)
          )
        ]
      ),
      child: Column(
        children: [
          _textYourInfo(),
          _textFieldEmail(),
          _textFieldPassword()
        ],
      ),
    );
  }

  /// Campo Textfield para ingresar correo.
  Widget _textFieldEmail(){
    return TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Correo electrónico',
        /// Propiedad Icon nos habilita una galeria completa de imagenes que podemos utilizar en nuestros componentes.
        prefixIcon: Icon(Icons.email)
      ),
    );
  }

  /// Campo Textfield para ingresar contraseña.
  Widget _textFieldPassword(){
    return TextField(
      keyboardType: TextInputType.text,
      /// Propiedad que permite ocultar password.
      obscureText: false,
      decoration: InputDecoration(
          hintText: 'Contraseña',
          /// Propiedad Icon nos habilita una galeria completa de imagenes que podemos utilizar en nuestros componentes.
          prefixIcon: Icon(Icons.lock)
      ),
    );
  }

  /// Text auxiliar en la pantalla principal.
  Widget _textYourInfo(){
    return Text('INGRESA ESTA INFORMACIÓN');
  }

  /// Texto que consulta al usuario sí ya tiene cuenta creada en la aplicación.
  Widget _textDontHaveAccount(){
    /// Ubicar elemento uno al lado del otro (horizontal).
    return Row(
      /// Centra los textos.
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '¿No tienes cuenta?',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 17
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Text(
            'Registrate Aquí',
          style: TextStyle(
              color: Colors.amber,
              fontWeight: FontWeight.bold,
              fontSize: 17
          ),
        )
      ],
    );
  }

  /// Cada vez que coloco un _ antes del nombre del método indica que ese método sera PRIVATE.
  Widget _imageCover(){
    /// SafeArea nos permite que la imagen baje un poco con respecto al eje y para que quede debajo de la barra de
    /// notificaciones del celular, adicionalmente este Widget lo generamos con Alt + Enter.
    return SafeArea(
      child: Container(
        /// Bajar la imágen un poco más allá de la barra de notificaciones del celular.
        margin: EdgeInsets.only(top: 20, bottom: 15),
        /// Centrar horizontal
        alignment: Alignment.center,
        child: Image.asset('assets/img/delivery.png',
          width: 130,
          height: 130,
        ),
      ),
    );
  }
}
