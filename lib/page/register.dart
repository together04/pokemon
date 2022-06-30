import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon/const.dart';
import 'package:pokemon/widget/snackBar.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

Future<void> register(BuildContext context, String email, String password,
    String nickname) async {
  final response = await http.post(
    Uri.parse(Const.signUp),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'email': email,
      'password': password,
      'nickname': nickname,
    }),
  );
  print(response.statusCode);
  if (response.statusCode == 201) {
    print('Success Register');
  }
  if (response.statusCode == 422) {
    showSnackBar(context, '올바른 정보를 입력해주세요.');
  } else {
    throw Exception('Failed to register');
  }
}

class _RegisterPageState extends State<RegisterPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _nicknameController;

  @override
  initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _nicknameController = TextEditingController();
    super.initState();
  }

  @override
  dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nicknameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: '이메일을 입력하세요'),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: '비밀번호를 입력하세요(4자리 이상)'),
                  obscureText: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _nicknameController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: '닉네임을 입력하세요'),
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  child: const Text(
                    '회원가입',
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
                    minimumSize: const Size.fromHeight(50),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                  ),
                  onPressed: () {
                    if (_emailController.text != '' &&
                        _passwordController.text != '' &&
                        _nicknameController.text != '') {
                      register(
                        context,
                        _emailController.text,
                        _passwordController.text,
                        _nicknameController.text,
                      );
                      Get.back();
                    } else {
                      showSnackBar(context, '정보입력이 올바르지않습니다.');
                    }
                  },
                ),
              ],
            ),
          ),
          Image.asset('assets/image/pokemon_back.png'),
        ],
      ),
    );
  }
}
