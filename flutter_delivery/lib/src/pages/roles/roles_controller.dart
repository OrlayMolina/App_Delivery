import 'package:flutter_delivery/src/models/user.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class RolesController extends GetxController {

  User user = User.fromJson(GetStorage().read('user') ?? {});
}