import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon/const.dart';
import 'package:pokemon/model/PokemonInfo.dart';

class PokemonPage extends StatefulWidget {
  const PokemonPage({Key? key}) : super(key: key);

  @override
  State<PokemonPage> createState() => _PokemonPageState();
}

Future<PokemonInfo> getUserSealInfo(int? sealNumber) async {
  final response = await http.get(
    Uri.parse(Const.sealInfo)
        .replace(queryParameters: {'seal_id': '$sealNumber'}),
    headers: {
      'Authorization': 'Bearer ${Const.token}',
    },
  );
  if (response.statusCode == 200) {
    return PokemonInfo.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  } else {
    throw Exception('Failed to load pokemon info');
  }
}

class _PokemonPageState extends State<PokemonPage> {
  late Future<PokemonInfo> future;
  Map<String, dynamic> rarity = {
    'LEGENDARY': 'SS',
    'HYPER': 'S',
    'EPIC': 'A',
    'RARE': 'B',
    'NORMAL': 'C',
  };

  @override
  initState() {
    future = getUserSealInfo(Get.arguments);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text('No.${snapshot.data.no} ${snapshot.data.name}'),
            ),
            body: Container(
              padding: EdgeInsets.all(20),
              child: Center(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 250,
                      child: Image.network(snapshot.data.imageUrl),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 5),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '이름: ${snapshot.data.name}',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      snapshot.data.description,
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '가격: ${snapshot.data.price}',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '희귀도: ${rarity[snapshot.data.rarity]}',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '속성: ${snapshot.data.kind}',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      child: const Text(
                        '도감 보러 가즈아',
                        style: TextStyle(fontSize: 20),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.purple,
                        minimumSize: const Size.fromHeight(50),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                      ),
                      onPressed: () {
                        Get.toNamed('/document');
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
