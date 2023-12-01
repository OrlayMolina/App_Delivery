import 'package:flutter_delivery/src/environment/environment.dart';
import 'package:get/get.dart';

import '../models/user.dart';

class UsersProvider extends GetConnect{

  String url = Environment.API_URL + 'api/users';

  Future<Response> create(User user) async {
    final userJson = user.toJson();
    print('User JSON: $userJson');

    // Agregar este print para verificar si se está realizando la solicitud POST.
    print('Enviando solicitud POST...');

    Response response = await post(
      '$url/create',
      userJson,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    return response;
  }

}