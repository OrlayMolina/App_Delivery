import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter_delivery/src/environment/environment.dart';
import 'package:flutter_delivery/src/models/response_api.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';

class UsersProvider extends GetConnect{

  String url = Environment.API_URL + 'api/users';

  Future<Response> create(User user) async {

    Response response = await post(
      '$url/create',
      user.toJson(),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    return response;
  }

  Future<Stream> createWithImage(User user, File image) async {
    Uri uri = Uri.http(Environment.API_URL_OLD, '/api/users/createWithImage');
    final request = http.MultipartRequest('POST', uri);
    request.files.add(http.MultipartFile(
        'image',
        http.ByteStream(image.openRead().cast()),
        await image.length(),
        filename: basename(image.path))
    );

    request.fields['user'] = json.encode(user);
    final response = await request.send();
    return response.stream.transform(utf8.decoder);
  }

  /**
   * GET X
   */
  Future<ResponseApi> createUserWithImageGetX(User user, File image) async {
    FormData form = FormData({
      'image': MultipartFile(image, filename: basename(image.path)),
      'user':json.encode(user)
    });

    Response response = await post('$url/createWithImage', form);

    if(response.body == null){
      Get.snackbar('Error en la petición', 'No se pudo crear el usuario');
      return ResponseApi();
    }

    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }

  Future<ResponseApi> login(String email, String password) async {

    Response response = await post(
      '$url/login',
      {
        'email': email,
        'password': password
      },
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if(response.body == null){
      Get.snackbar('Error ', 'No se puedo ejecutar la petición');
      return ResponseApi();
    }

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }

}