import 'package:data_overview_layer/features/ecommerce/presentation/bloc/product_bloc.dart';
import 'package:data_overview_layer/features/ecommerce/presentation/bloc/product_event.dart';
import 'package:data_overview_layer/features/ecommerce/presentation/pages/add_product_page.dart';
import 'package:data_overview_layer/features/ecommerce/presentation/pages/home_page.dart';
import 'package:data_overview_layer/features/ecommerce/presentation/pages/search_page.dart';
import 'package:data_overview_layer/injection_container.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<ProductBloc>()..add(LoadAllProductEvent()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
      
        initialRoute: HomePage.routeName,
      
        routes: {
          HomePage.routeName: (_) => const HomePage(),
          AddProduct.routeName: (_) => AddProduct(),
          SearchPage.routeName: (_) => SearchPage()
        },
      ),
    );
  }
}