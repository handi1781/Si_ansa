import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:si_ansa/login_screen/login_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  changeScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const login_screen(),
      ));
    });
  }

  @override
  void initState() {
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/images/bg.jpg',
                  ),
                  opacity: 220),
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 139, 141, 139),
                  Color.fromARGB(218, 161, 164, 163)
                ],
              )),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 340,
                ),
                Image.asset(
                  'assets/images/flutter.png',
                  width: 100,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'PT. Ansa',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(login_screen());
          },
          child: Icon(Icons.arrow_circle_right),
          backgroundColor: Colors.black,
        ));
  }
}
