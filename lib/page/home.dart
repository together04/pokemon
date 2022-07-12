import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon/const.dart';
import 'package:pokemon/widget/pokemon_listview.dart';
import 'package:pokemon/widget/snackBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

Future<void> login(BuildContext context, String email, String password) async {
  final response = await http.post(
    Uri.parse(Const.signIn),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'email': email,
      'password': password,
    }),
  );
  if (response.statusCode == 200) {
    showSnackBar(context, '로그인에 성공하였습니다.');
    Const.token = jsonDecode(response.body);
  } else if (response.statusCode == 400) {
    showSnackBar(context, '이메일이 올바르지 않습니다.');
  } else if (response.statusCode == 403) {
    showSnackBar(context, '비밀번호가 올바르지 않습니다.');
  } else if (response.statusCode == 422) {
    showSnackBar(context, '올바른 정보를 입력해주세요.');
  }
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController1 = ScrollController();
  final ScrollController _scrollController2 = ScrollController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      double minScrollExtent1 = _scrollController1.position.minScrollExtent;
      double maxScrollExtent1 = _scrollController1.position.maxScrollExtent;
      double minScrollExtent2 = _scrollController2.position.minScrollExtent;
      double maxScrollExtent2 = _scrollController2.position.maxScrollExtent;

      animateToMaxMin(maxScrollExtent1, minScrollExtent1, maxScrollExtent1, 100,
          _scrollController1);
      animateToMaxMin(maxScrollExtent2, minScrollExtent2, maxScrollExtent2, 120,
          _scrollController2);
    });
  }

  animateToMaxMin(double max, double min, double direction, int seconds,
      ScrollController scrollController) {
    scrollController
        .animateTo(direction,
            duration: Duration(seconds: seconds), curve: Curves.linear)
        .then((value) {
      direction = direction == max ? min : max;
      animateToMaxMin(max, min, direction, seconds, scrollController);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: InkWell(
        child: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 30),
                Column(
                  children: [
                    PokemonListView(
                        scrollController: _scrollController1,
                        images: Const.pokemon.reversed.toList()),
                    PokemonListView(
                        scrollController: _scrollController2,
                        images: Const.pokemon),
                  ],
                ),
                const Text(
                  '띠부띠부 도감',
                  style: TextStyle(
                      fontSize: 36,
                      color: Colors.black,
                      fontWeight: FontWeight.w800),
                ),
                const Text(
                  '터치하여 시작하기',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                      fontWeight: FontWeight.w800),
                ),
                Image.asset('assets/image/pokemon_back.png'),
              ],
            ),
          ),
        ),
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return loginPage();
            },
          );
        },
      ),
    );
  }

  Widget loginPage() {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
                    border: OutlineInputBorder(), hintText: '비밀번호를 입력하세요'),
                obscureText: true,
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                child: const Text(
                  '로그인',
                  style: TextStyle(fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.purple,
                  minimumSize: const Size.fromHeight(50),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                ),
                onPressed: () {
                  login(
                    context,
                    _emailController.text,
                    _passwordController.text,
                  );
                  Get.offAllNamed('/document');
                },
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                child: const Center(
                  child: Text('아직 계정이 없으신가요?'),
                ),
                onTap: () {
                  Get.toNamed('register');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
