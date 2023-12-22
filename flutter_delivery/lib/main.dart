import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/models/user.dart';
import 'package:flutter_delivery/src/pages/home/home_page.dart';
import 'package:flutter_delivery/src/pages/login/login_page.dart';
import 'package:flutter_delivery/src/pages/register/register_page.dart';
import 'package:flutter_delivery/src/pages/roles/roles_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

User userSession = User.fromJson(GetStorage().read('user') ?? {});

void main() async {
  await GetStorage.init();
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
      /// Routa principal de la aplicación, sí el id de la session es null ira a la ruta principal de lo contrario al home.
      initialRoute: userSession.id != null ? '/home' : '/',
      /// Páginas de la aplicación
      getPages: [
        GetPage(name: '/', page: () => LoginPage()),
        GetPage(name: '/register', page: () => RegisterPage()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/roles', page: () => RolesPage())
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
