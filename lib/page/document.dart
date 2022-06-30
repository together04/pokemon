import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:pokemon/const.dart';
import 'package:pokemon/model/UserHasSealInfo.dart';

class DocumentPage extends StatefulWidget {
  const DocumentPage({Key? key}) : super(key: key);

  @override
  State<DocumentPage> createState() => _DocumentPageState();
}

Future<UserHasSealInfo> getUserSealInfo() async {
  final response = await http.get(
    Uri.parse(Const.sealUser),
    headers: {
      'Authorization': 'Bearer ${Const.token}',
    },
  );
  if (response.statusCode == 200) {
    return UserHasSealInfo.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load document');
  }
}

class _DocumentPageState extends State<DocumentPage> {
  late Future<UserHasSealInfo> future;

  @override
  initState() {
    future = getUserSealInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '포켓몬도감',
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
        future: future,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return GridView.builder(
              itemCount: Const.pokemon.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, //1 개의 행에 보여줄 item 개수
                childAspectRatio: 1 / 1.5, //item 의 가로 1, 세로 2 의 비율
                mainAxisSpacing: 10, //수평 Padding
                crossAxisSpacing: 10,
              ),
              itemBuilder: (BuildContext context, int index) {
                if (snapshot.data.sealId.contains(index + 1)) {
                  return _documentItem(index, true);
                } else {
                  return _documentItem(index, false);
                }
              },
            );
          }
        },
      ),
      floatingActionButton: speedDialButton(context),
    );
  }

  Widget speedDialButton(BuildContext context) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: const IconThemeData(
        size: 22,
        color: Colors.white,
      ),
      backgroundColor: Colors.purple,
      visible: true,
      curve: Curves.bounceIn,
      spacing: 10.0,
      spaceBetweenChildren: 10.0,
      children: [
        SpeedDialChild(
          child: const Icon(
            Icons.add_a_photo,
            color: Colors.white,
          ),
          backgroundColor: Colors.purple,
          onTap: () {
            getImage(ImageSource.camera);
          },
          label: '사진찍기',
          labelBackgroundColor: Colors.purple,
          labelStyle: const TextStyle(color: Colors.white),
        ),
        SpeedDialChild(
          child: const Icon(
            Icons.wallpaper,
            color: Colors.white,
          ),
          backgroundColor: Colors.purple,
          onTap: () {
            getImage(ImageSource.gallery);
          },
          label: '갤러리 열기',
          labelBackgroundColor: Colors.purple,
          labelStyle: const TextStyle(color: Colors.white),
        )
        // labelStyle: TextStyle(color: ColorData.sky))
      ],
    );
  }

  Widget _documentItem(int sealNumber, bool _isHas) {
    return Padding(
      padding: EdgeInsets.only(top: 5.0),
      child: InkWell(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  child: Text(
                    'No.${(sealNumber + 1).toString().padLeft(3, '0')}',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Expanded(
                  child: Image.asset(
                    'assets/image/${Const.pokemon[sealNumber]}',
                  ),
                )
              ],
            ),
            Container(
              color: _isHas ? Colors.transparent : Color(0x88A4A4A4),
            ),
          ],
        ),
        onTap: () {
          _isHas
              ? Get.toNamed(
                  '/pokemon',
                  arguments: sealNumber + 1,
                )
              : print('no seal');
        },
      ),
    );
  }

  Future getImage(ImageSource imageSource) async {
    final image = await ImagePicker().pickImage(source: imageSource);
    Get.toNamed(
      '/seal',
      arguments: File(image!.path),
    );
  }
}
