import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:products_app/models/models.dart';
import 'package:products_app/screens/screens.dart';
import 'package:products_app/services/services.dart';
import 'package:products_app/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ProductsService>(context);
    final authService = Provider.of<AuthService>(context, listen: false);

    if (productsService.isLoading) return LoadingScreen();
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.login_outlined),
          onPressed: () {
            // En este caso no hace falta poner async y await porque
            //no me interesa esperar a que se termine la accion sino
            //que directamente termine la sesion y redirija al login
            authService.logout();
            Navigator.pushReplacementNamed(context, 'login');
          },
        ),
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: productsService.products.length,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
            child: ProductCard(product: productsService.products[index]),
            onTap: () {
              // Indico el producto seleccionado y lo copio para romper la referencia,
              // es decir poder trabajar sin cambiar el original
              productsService.selectedProduct = productsService.products[index].copy();
              Navigator.pushNamed(context, 'product');
            }),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          productsService.selectedProduct = new Product(
            available: false,
            name: '',
            price: 0,
          );
          Navigator.pushNamed(context, 'product');
        },
      ),
    );
  }
}
