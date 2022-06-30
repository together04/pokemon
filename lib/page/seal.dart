import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon/const.dart';
import 'package:pokemon/model/UserSealInfo.dart';

class SealPage extends StatefulWidget {
  const SealPage({Key? key}) : super(key: key);

  @override
  _SealPageState createState() => _SealPageState();
}

Future<int?> uploadImage(filename) async {
  var request = http.MultipartRequest('POST', Uri.parse(Const.sealUser));
  request.files.add(await http.MultipartFile.fromPath('seal_image', filename));
  request.headers.addAll({
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${Const.token}'
  });
  var response = await request.send();
  var res = await http.Response.fromStream(response);

  if (response.statusCode == 201) {
    print('Success upload image');
  } else {
    throw Exception('Failed to upload image');
  }

  return UserSealInfo.fromJson(json.decode(res.body)).sealId;
}

class _SealPageState extends State<SealPage> {
  late Future<UserSealInfo> future;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('사진 등록하기'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 25.0),
          Container(
            color: const Color(0xffd0cece),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            child: Center(
              child: Image.file(
                File(Get.arguments!.path),
              ),
            ),
          ),
          const SizedBox(height: 50.0),
          Padding(
            padding: EdgeInsets.all(20),
            child: ElevatedButton(
              child: Text('사진 등록하기'),
              style: ElevatedButton.styleFrom(
                primary: Colors.purple,
                minimumSize: const Size.fromHeight(50),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              ),
              onPressed: () async {
                Get.toNamed(
                  '/pokemon',
                  arguments: await uploadImage(Get.arguments!.path),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
