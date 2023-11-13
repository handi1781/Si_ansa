import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:si_ansa/login_screen/login_screen.dart';

class forgot_pass extends StatefulWidget {
  const forgot_pass({super.key});

  @override
  State<forgot_pass> createState() => _forgot_passState();
}

class _forgot_passState extends State<forgot_pass> {
  RxBool isLoading = false.obs;
  final emailC = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> sendEmail() async {
    if (emailC.text.isNotEmpty) {
      try {
        await auth.sendPasswordResetEmail(email: emailC.text);
      } catch (e) {
        Get.snackbar('Terjadi Kesalahan', 'Tidak dapat Mengirim Email');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lupa Password'),
        backgroundColor: Colors.redAccent,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            'Silahkan Ganti Password Anda',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: emailC,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.redAccent),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  fillColor: Colors.black,
                  label: Text('Masukkan Email')),
            ),
          ),
          ElevatedButton.icon(
              onPressed: () async {
                if (isLoading.isFalse) {
                  await sendEmail();
                  Get.snackbar('Sukses', 'Silahkan Cek Email Anda');
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const login_screen(),
                  ));
                }
              },
              icon: Icon(Icons.change_circle),
              label: Text(isLoading.isFalse ? 'Ganti' : 'Memuat'))
        ],
      ),
    );
  }
}
