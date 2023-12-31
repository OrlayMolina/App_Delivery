import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_delivery/src/models/category.dart';
import 'package:flutter_delivery/src/models/product.dart';
import 'package:flutter_delivery/src/pages/client/products/list/client_products_list_controller.dart';
import 'package:flutter_delivery/src/widgets/no_data_widget.dart';
import 'package:get/get.dart';

class ClientProductsListPage extends StatelessWidget {

  ClientProductsListController controller = Get.put(
      ClientProductsListController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => DefaultTabController(
      length: controller.categories.length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(110),
          child: AppBar(
            flexibleSpace: Container(
              margin: EdgeInsets.only(top: 15),
              alignment: Alignment.topCenter,
              child: Wrap(
                direction: Axis.horizontal,
                children: [
                  _textFieldSearch(context),
                  _iconShoppingBag()
                ],
              ),
            ),
            bottom: TabBar(
              isScrollable: true,
              indicatorColor: Colors.amber,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey[600],
              tabs: List<Widget>.generate(controller.categories.length, (index) {
                return Tab(
                  child: Text(controller.categories[index].name ?? ''),
                );
              }),
            ),
          ),
        ),
        body: TabBarView(
          children: controller.categories.map((Category category){
            return FutureBuilder(
                future: controller.getProducts(category.id ?? '1'),
                builder: (context, AsyncSnapshot<List<Product>> snapshot){
                  if(snapshot.hasData){

                    if(snapshot.data!.length > 0){
                      return ListView.builder(
                        itemCount: snapshot.data?.length ?? 0,
                        itemBuilder: (_,index){
                          return _cardProduct(context, snapshot.data![index]);
                        },
                      );
                    }else {
                      return NoDataWidget(text: 'No hay productos');
                    }

                  }else {
                    return NoDataWidget(text: 'No hay productos');
                  }
                }
            );
          }).toList(),
        )
      ),
    ));
  }

  Widget _iconShoppingBag() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(left: 10),
        child: IconButton(
            onPressed: () => controller.goToOrderCreate(),
            icon: Icon(
              Icons.shopping_bag_outlined,
              color: Colors.black,
              size: 30,
            )
        ),
      ),
    );
  }

  Widget _textFieldSearch(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width  * 0.75,
        child: TextField(
          decoration: InputDecoration(
              hintText: 'Buscar producto',
              suffixIcon: Icon(Icons.search, color: Colors.grey),
              hintStyle: TextStyle(
                  fontSize: 17,
                  color: Colors.grey
              ),
              fillColor: Colors.white,
              filled: true,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                      color: Colors.grey
                  )
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                      color: Colors.grey
                  )
              ),
              contentPadding: EdgeInsets.all(10)
          ),
        ),
      ),
    );
  }

  Widget _cardProduct(BuildContext context, Product product){
    return GestureDetector(
      onTap: () => controller.openBottomSheet(context, product),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 15, left: 20, right: 5),
            child: ListTile(
              title: Text(product.name ?? '', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15),
                  Text(product.description ?? '', maxLines: 2, style: TextStyle(color: Colors.grey[800])),
                  SizedBox(height: 10),
                  Text(
                    '\$ ${product.price.toString()}',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                ],
              ),
              /// a la izq leading a la derecha triling.
              trailing: Container(
                height: 100,
                width: 90,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FadeInImage(
                    image: product.image1 != null
                        ? NetworkImage(product.image1!)
                        : AssetImage('assets/img/no-image.png') as ImageProvider,
                    fit: BoxFit.cover,
                    fadeInDuration: Duration(milliseconds: 50),
                    placeholder: AssetImage('assets/img/no-image.png'),
                  ),
                ),
              ),
            ),
          ),
          Divider(height: 1, color: Colors.grey[400], indent: 30, endIndent: 30)
        ],
      ),
    );
  }
}
