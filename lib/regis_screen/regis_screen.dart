import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:si_ansa/login_screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class regis_screen extends StatefulWidget {
  const regis_screen({super.key});

  @override
  State<regis_screen> createState() => _regis_screenState();
}

class _regis_screenState extends State<regis_screen> {
  RxBool isLoading = false.obs;
  final nameC = TextEditingController();
  final nipC = TextEditingController();
  final emailC = TextEditingController();
  final passC = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<void> addPegawai() async {
    if (nameC.text.isNotEmpty &&
        nipC.text.isNotEmpty &&
        emailC.text.isNotEmpty &&
        passC.text.isNotEmpty) {
      try {
        UserCredential userCredential =
            await auth.createUserWithEmailAndPassword(
                email: emailC.text, password: passC.text);
        if (userCredential.user != null) {
          String? uid = userCredential.user?.uid;
          firestore.collection("pegawai").doc(uid).set({
            "nip": nipC.text,
            "nama": nameC.text,
            "email": emailC.text,
            "uid": uid,
            "role": "pegawai",
            "createdAt": DateTime.now().toIso8601String()
          });
          await userCredential.user!.sendEmailVerification();
        }
        print(userCredential);

        Get.snackbar("Daftar berhasil", "Silahkan Login");
        Get.to(login_screen());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Get.snackbar(
              "Terjadi Kesalahan", "password yang di gunakan terlalu singkat");
        } else if (e.code == 'email-already-in-use') {
          Get.snackbar("Terjadi Kesalahan", "Pegawai sudah ada");
        }
      } catch (e) {
        Get.snackbar("Terjadi Kesalahan", "Tidak dapat menambahkan pegawai");
      }
    } else {
      Get.snackbar('Terjadi Kesalahan', 'NIP, Nama, Email Harus di isi');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Akun'),
        backgroundColor: Colors.redAccent,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            'Registasi Dulu Ya, Ok',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: nameC,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.redAccent),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  fillColor: Colors.black,
                  label: Text('Nama')),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: nipC,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.redAccent),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  fillColor: Colors.black,
                  label: Text('NIP')),
            ),
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
                label: Text('Email'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              obscureText: true,
              controller: passC,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 3, color: Colors.redAccent),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                fillColor: Colors.black,
                label: Text('Password'),
              ),
            ),
          ),
          ElevatedButton.icon(
              onPressed: () async {
                if (isLoading.isFalse) {
                  await addPegawai();
                  Get.snackbar('Sukses Mendaftar', 'Silahkan Login');
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const login_screen(),
                  ));
                }
              },
              icon: Icon(Icons.app_registration_rounded),
              label: Text(isLoading.isFalse ? 'Daftar' : 'Memuat'))
        ],
      ),
    );
  }
}
