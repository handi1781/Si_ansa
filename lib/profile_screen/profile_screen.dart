import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:si_ansa/forgot_pass_screen/update_pass.dart';
import 'package:si_ansa/home_screen/home_screen.dart';
import 'package:si_ansa/login_screen/login_screen.dart';
import 'package:si_ansa/profile_screen/update_screen.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  RxBool isLoading = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser() async* {
    String uid = await auth.currentUser!.uid;
    yield* firestore.collection("pegawai").doc(uid).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile ku'),
        backgroundColor: Colors.redAccent,
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: streamUser(),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snap.hasData) {
              Map<String, dynamic> user = snap.data!.data()!;
              return ListView(
                padding: EdgeInsets.all(20),
                children: [
                  CircleAvatar(
                      radius: 50,
                      child: Image.network(
                        user["profile"] != null
                            ? user["profile"] != ""
                                ? user["profile"]
                                : "https://th.bing.com/th/id/OIP.oDG8UA1t9hhTsw3-oauGMQHaJn?pid=ImgDet&rs=1"
                            : "https://th.bing.com/th/id/OIP.oDG8UA1t9hhTsw3-oauGMQHaJn?pid=ImgDet&rs=1",
                        fit: BoxFit.cover,
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "${user['nama'].toString().toUpperCase()}",
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${user['email'].toString()}",
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${user['role'].toString()}",
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    onTap: () {
                      Get.to(update(), arguments: user);
                    },
                    leading: Icon(Icons.person_2),
                    title: Text('Update Profile'),
                  ),
                  ListTile(
                    onTap: () {
                      Get.to(update_pass());
                    },
                    leading: Icon(Icons.password),
                    title: Text('Ubah Password'),
                  ),
                  ListTile(
                    onTap: () async {
                      if (isLoading.isFalse) {
                        isLoading.value = true;
                        await FirebaseAuth.instance.signOut();
                        isLoading.value = false;
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const login_screen(),
                        ));
                      }
                    },
                    leading: isLoading.isFalse
                        ? Icon(Icons.logout_rounded)
                        : CircularProgressIndicator(),
                    title: Text('Keluar'),
                  )
                ],
              );
            } else {
              return Center(
                child: Text('Tidak Dapat Data'),
              );
            }
          }),
    );
  }
}
