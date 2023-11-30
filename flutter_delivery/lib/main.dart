import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/pages/login/login_page.dart';
import 'package:flutter_delivery/src/pages/register/register_page.dart';
import 'package:get/get.dart'; /// Paquete que nos permite usar todas las funcionalidades de Getx

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  /// Método build encargado de construir las vistas de la aplicación.
  @override
  Widget build(BuildContext context) {
    /// Agregamos configuraciones de nuestra aplicación.
    return GetMaterialApp(
      /// Título de la aplicación.
      title: 'Delivery App',
      /// No mostrará la marca de 'debug' en la aplicación.
      debugShowCheckedModeBanner: false,
      /// Routa principal de la aplicación.
      initialRoute: '/',
      /// Páginas de la aplicación
      getPages: [
        GetPage(name: '/', page: () => LoginPage()),
        GetPage(name: '/register', page: () => RegisterPage())
      ],
      theme: ThemeData(
        primaryColor: Colors.amber,
        colorScheme: ColorScheme(
            primary: Colors.amber,
            secondary: Colors.amberAccent,
            onSecondary: Colors.grey,
            brightness: Brightness.light,
            background: Colors.white,
            onBackground: Colors.white,
            onPrimary: Colors.amber,
            surface: Colors.amber,
            onSurface: Colors.grey,
            error: Colors.grey,
            onError: Colors.grey
        )
      ),
      navigatorKey: Get.key,
    );
  }

}
