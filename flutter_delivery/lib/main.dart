import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/pages/login/login_page.dart';
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
        GetPage(name: '/', page: () => const LoginPage())
      ],
      navigatorKey: Get.key,
    );
  }

}
