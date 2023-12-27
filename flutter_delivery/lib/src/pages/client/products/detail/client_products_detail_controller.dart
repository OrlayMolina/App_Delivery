import 'package:flutter_delivery/src/models/product.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ClientProductsDetailController extends GetxController {

  Product? product;

  var counter = 0.obs;
  var price = 0.0.obs;
  List<Product> selectedProducts = [];

  ClientProductsDetailController(Product product){
    this.product = product;
    price.value = product.price ?? 0.0;

    print('GET STORAGE: ${GetStorage().read('shopping_bag')}');

    /// Obtenemos los productos almacenados en sesión de usuario.
    if (GetStorage().read('shopping_bag') != null) {

      if (GetStorage().read('shopping_bag') is List<Product>) {
        selectedProducts = GetStorage().read('shopping_bag');
      }
      else {
        selectedProducts = Product.fromJsonList(GetStorage().read('shopping_bag'));
      }

      int index = selectedProducts.indexWhere((p) => p.id == product.id);
      counter.value = selectedProducts[index].quantity ?? 0;
      price.value = product.price! * counter.value;

      selectedProducts.forEach((p) {
        print('Producto: ${p.toJson()}');
      });

    }
  }

  void addToBag(){

    if (counter.value > 0) {
      /// Validar si el producto ya fue agregado al getstorage en la sesión del dispositivo
      int index = selectedProducts.indexWhere((p) => p.id == product?.id);

      if(index == -1){/// No ha sido agregado al GetStorage
        if(product?.quantity == null){
          product?.quantity = 1;
        }

        selectedProducts.add(product!);
      }else {/// El producto ya fue agregado al Storage
        selectedProducts[index].quantity = counter.value;
      }

      GetStorage().write('shopping_bag', selectedProducts);
      Fluttertoast.showToast(msg: 'Producto agregado');

    }else {
      Fluttertoast.showToast(msg: 'Debes seleccionar al menos un item para agregar');
    }

  }

  void addItem() {
    counter.value = counter.value + 1;
    price.value = product!.price! * counter.value;
  }

  void removeItem() {
    if (counter.value > 0) {
      counter.value = counter.value - 1;
      price.value = product!.price! * counter.value;
    }
  }
}