import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemon/page/document.dart';
import 'package:pokemon/page/home.dart';
import 'package:pokemon/page/pokemon.dart';
import 'package:pokemon/page/register.dart';
import 'package:pokemon/page/seal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'pokemon',
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/register', page: () => RegisterPage()),
        GetPage(name: '/document', page: () => DocumentPage()),
        GetPage(name: '/seal', page: () => SealPage()),
        GetPage(name: '/pokemon', page: () => PokemonPage()),
        GetPage(name: '/home', page: () => HomePage()),
      ],
      home: HomePage(),
    );
  }
}
