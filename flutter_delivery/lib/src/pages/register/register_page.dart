import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/pages/register/register_controller.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {

  RegisterController controller = Get.put(RegisterController());

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
          _buttonBack()
        ],
      ),
    );
  }

  /**
   * Método que permitirá navegar hacia la pantalla principal de la aplicación.
   */
  Widget _buttonBack(){
    return SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 10),
          child: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 30,
            ),
          ),
        )
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
      height: MediaQuery.of(context).size.height * 0.65,
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
            _textFieldEmail(),
            _textFieldName(),
            _textFieldLastName(),
            _textFieldPhone(),
            _textFieldPassword(),
            _textFieldConfirmPassword(),
            _buttonRegister(context)
          ],
        ),
      ),
    );
  }

  /// Campo Textfield para ingresar correo.
  Widget _textFieldEmail(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: controller.emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            hintText: 'Correo electrónico',
            /// Propiedad Icon nos habilita una galeria completa de imagenes que podemos utilizar en nuestros componentes.
            prefixIcon: Icon(Icons.email)
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
        decoration: InputDecoration(
            hintText: 'Nombre',
            /// Propiedad Icon nos habilita una galeria completa de imagenes que podemos utilizar en nuestros componentes.
            prefixIcon: Icon(Icons.person)
        ),
      ),
    );
  }

  /// Campo Textfield para ingresar el apellido del usuario.
  Widget _textFieldLastName(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: controller.lastnameController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            hintText: 'Apellido',
            /// Propiedad Icon nos habilita una galeria completa de imagenes que podemos utilizar en nuestros componentes.
            prefixIcon: Icon(Icons.person_outline)
        ),
      ),
    );
  }

  /// Campo Textfield para ingresar el número celular del usuario.
  Widget _textFieldPhone(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: controller.phoneController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            hintText: 'Número Celular',
            /// Propiedad Icon nos habilita una galeria completa de imagenes que podemos utilizar en nuestros componentes.
            prefixIcon: Icon(Icons.phone)
        ),
      ),
    );
  }

  /// Campo Textfield para ingresar contraseña.
  Widget _textFieldPassword(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
      child: TextField(
        controller: controller.passwordController,
        keyboardType: TextInputType.text,
        /// Propiedad que permite ocultar password.
        obscureText: true,
        decoration: InputDecoration(
            hintText: 'Contraseña',
            /// Propiedad Icon nos habilita una galeria completa de imagenes que podemos utilizar en nuestros componentes.
            prefixIcon: Icon(Icons.lock)
        ),
      ),
    );
  }

  /// Campo Textfield para confirmar contraseña.
  Widget _textFieldConfirmPassword(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
      child: TextField(
        controller: controller.confirmPasswordController,
        keyboardType: TextInputType.text,
        /// Propiedad que permite ocultar password.
        obscureText: true,
        decoration: InputDecoration(
            hintText: 'Confirmar Contraseña',
            /// Propiedad Icon nos habilita una galeria completa de imagenes que podemos utilizar en nuestros componentes.
            prefixIcon: Icon(Icons.lock_outline)
        ),
      ),
    );
  }

  /// Widget que muestra el botón de login.
  Widget _buttonRegister(BuildContext context){
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      child: ElevatedButton(
          onPressed: () => controller.register(context),
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15)
          ),
          child: Text(
            'REGISTRARSE',
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
        child: GestureDetector(
          onTap: () => controller.showAlertDialog(context),
          child: GetBuilder<RegisterController> (
            builder: (value) => CircleAvatar(
              /// NULL SAFETY
              backgroundImage: controller.imageFile != null ? FileImage(controller.imageFile!) :
              AssetImage('assets/img/user_profile.png') as ImageProvider,
              radius: 60,
              backgroundColor: Colors.white,
            ),
          )
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
