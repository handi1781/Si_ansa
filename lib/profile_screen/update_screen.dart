import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:si_ansa/home_screen/home_screen.dart';
import 'package:si_ansa/profile_screen/profile_screen.dart';
import 'package:image_picker/image_picker.dart';

class update extends StatefulWidget {
  const update({super.key});

  @override
  State<update> createState() => _updateState();
}

class _updateState extends State<update> {
  RxBool isLoading = false.obs;
  final Map<String, dynamic> user = Get.arguments;
  final nameC = TextEditingController();
  final nipC = TextEditingController();
  final emailC = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<void> updateProfile(String uid) async {
    if (nipC.text.isNotEmpty &&
        nameC.text.isNotEmpty &&
        emailC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        await firestore
            .collection("pegawai")
            .doc(uid)
            .update({"nama": nameC.text});
        Get.snackbar("Berhasil", "Berhasil update data");
      } catch (e) {
        Get.snackbar("Terjadi Kesalahan", "Tidak dapat mengubah data");
      } finally {
        isLoading.value = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print(user);
    nipC.text = user["nip"];
    nameC.text = user["nama"];
    emailC.text = user["email"];

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
              readOnly: true,
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
              readOnly: true,
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
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
              padding: EdgeInsets.all(8),
              alignment: Alignment.centerLeft,
              child: Text("Note: Hanya bisa mengubah nama dan gambar")),
          ElevatedButton.icon(
              onPressed: () async {
                if (isLoading.isFalse) {
                  await updateProfile(user["uid"]);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const profile(),
                  ));
                }
              },
              icon: Icon(Icons.app_registration_rounded),
              label: Text(isLoading.isFalse ? 'Ubah Profile' : 'Memuat'))
        ],
      ),
    );
  }
}
