import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../profile_screen/profile_screen.dart';

class update_pass extends StatefulWidget {
  const update_pass({super.key});

  @override
  State<update_pass> createState() => _update_passState();
}

class _update_passState extends State<update_pass> {
  RxBool isLoading = false.obs;
  final currC = TextEditingController();
  final newC = TextEditingController();
  final confirmC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> updatePass() async {
    if (currC.text.isNotEmpty &&
        newC.text.isNotEmpty &&
        confirmC.text.isNotEmpty) {
      if (newC.text == confirmC.text) {
        isLoading.value = true;
        try {
          String emailUser = auth.currentUser!.email!;
          await auth.signInWithEmailAndPassword(
              email: emailUser, password: currC.text);
          await auth.currentUser!.updatePassword(newC.text);
          Get.back();
          Get.snackbar('Behasil', 'Berhasil Update password');
        } on FirebaseAuthException catch (e) {
          if (e.code == "wrong-password") {
            Get.snackbar(
                'terjadi kesalahan', 'password yang di masukkan salah');
          } else {
            Get.snackbar('Terjadi Kesalahan', '${e.code.toLowerCase()}');
          }
        } catch (e) {
          Get.snackbar('Terjadi Kesalahan', 'tidak dapat update password');
        } finally {
          isLoading.value = false;
        }
      } else {
        Get.snackbar('Terjadi Kesalahan', 'Confrim password salah');
      }
    } else {
      Get.snackbar('Terjadi Kesalahan', 'Semua input harus di isi');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ubah Profile'),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            'Silahkan Ubah Data Anda',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: currC,
              obscureText: true,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.redAccent),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  fillColor: Colors.black,
                  label: Text('Password sekarang')),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: newC,
              obscureText: true,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.redAccent),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  fillColor: Colors.black,
                  label: Text('Password baru')),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: confirmC,
              obscureText: true,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 3, color: Colors.redAccent),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                fillColor: Colors.black,
                label: Text('Konfirmasi password baru'),
              ),
            ),
          ),
          ElevatedButton.icon(
              onPressed: () async {
                if (isLoading.isFalse) {
                  await updatePass();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const profile(),
                  ));
                }
              },
              icon: Icon(Icons.app_registration_rounded),
              label: Text(isLoading.isFalse ? 'Ubah Password' : 'Memuat'))
        ],
      ),
    );
  }
}
