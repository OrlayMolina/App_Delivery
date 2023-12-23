import 'package:flutter_delivery/src/environment/environment.dart';
import 'package:flutter_delivery/src/models/category.dart';
import 'package:flutter_delivery/src/models/response_api.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/user.dart';

class CategoriesProvider extends GetConnect {

  String url = Environment.API_URL + 'api/categories';

  User userSession = User.fromJson(GetStorage().read('user') ?? {});

  Future<ResponseApi> create(Category category) async {

    Response response = await post(
      '$url/create',
      category.toJson(),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': userSession.sessionToken ?? ''
      },
    );

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }
}