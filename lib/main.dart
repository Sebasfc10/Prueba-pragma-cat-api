import 'package:cat_api_prueba_pragma_jeant/config/bloc/bloc/cat_bloc.dart';
import 'package:cat_api_prueba_pragma_jeant/infraestructure/resource/cat_api_repositoy.dart';
import 'package:cat_api_prueba_pragma_jeant/ui/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: false,
      ),
      home: HomePage(),
    );
  }
}
