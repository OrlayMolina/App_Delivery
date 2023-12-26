import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_delivery/src/pages/client/products/detail/client_products_detail_controller.dart';
import 'package:get/get.dart';

class ClientProductsDetailPage extends StatelessWidget {

  ClientProductsDetailController controller = Get.put(ClientProductsDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Client Products Detail Page'),
      ),
    );
  }
}
