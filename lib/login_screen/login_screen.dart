import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:si_ansa/forgot_pass_screen/forgot_screen.dart';
import 'package:si_ansa/home_screen/home_screen.dart';
import 'package:si_ansa/regis_screen/regis_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class login_screen extends StatefulWidget {
  const login_screen({super.key});

  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
  RxBool isLoading = false.obs;
  final emailC = TextEditingController();
  final passC = TextEditingController();

  Future<void> login() async {
    if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailC.text, password: passC.text);
        print(userCredential);

        if (userCredential.user != null) {
          isLoading.value = false;
          if (userCredential.user!.emailVerified == true) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const home_screen(),
            ));
          } else {
            Get.defaultDialog(
                title: "Belum Verifikasi",
                middleText: "Lakukan Verifikasi Email",
                actions: [
                  TextButton(
                      onPressed: () {
                        isLoading.value = false;
                        Get.back();
                      },
                      child: Text('Cancel')),
                  TextButton(
                      onPressed: () async {
                        try {
                          await userCredential.user!.sendEmailVerification();
                          Get.snackbar("Sukses verifikasi", "Silahkan Login");
                          Get.back();
                          isLoading.value = false;
                        } catch (e) {
                          isLoading.value = false;
                          Get.snackbar("Terjadi kesalahan",
                              "Coba cek kembali email anda");
                        }
                      },
                      child: Text('Kirim Ulang'))
                ]);
          }
        }
        isLoading.value = false;
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        if (emailC.text != UserCredential) {
          Get.snackbar("Terjadi Kesalahan", "User tidak terdaftar");
        } else if (passC.text != UserCredential) {
          Get.snackbar("Terjadi Keslahan", "Password anda salah");
        }
      }
    } else {
      Get.snackbar("Terjadi Kesalahan", "Email dan Password wajib di isi");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/logo.jpg'), opacity: 230)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                          image: AssetImage('assets/images/bonek11.png')),
                    ),
                    height: 190,
                  ),
                  Text(
                    'Login Dulu Berr',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: emailC,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 3, color: Colors.redAccent),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          fillColor: Colors.black,
                          label: Text('Email')),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: passC,
                      obscureText: true,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 3, color: Colors.redAccent),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        fillColor: Colors.black,
                        label: Text('Password'),
                      ),
                    ),
                  ),
                  Container(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                          onPressed: () {
                            Get.to(forgot_pass());
                          },
                          child: Text('Lupa Password?'))),
                  Obx(
                    () => ElevatedButton.icon(
                      onPressed: () async {
                        if (isLoading.isFalse) {
                          await login();
                        }
                      },
                      icon: Icon(Icons.login),
                      label: Text(isLoading.isFalse ? 'Masuk' : 'Memuat...'),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Get.to(regis_screen());
                    },
                    icon: Icon(Icons.app_registration),
                    label: Text('Daftar'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
