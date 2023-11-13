import 'package:flutter/material.dart';

class absen_screen extends StatefulWidget {
  const absen_screen({super.key});

  @override
  State<absen_screen> createState() => _absen_screenState();
}

class _absen_screenState extends State<absen_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Absensi'),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/logo.jpg'),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Selamat Datang',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Container(
                  height: 230,
                  width: 400,
                  decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(20)),
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.all(13),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Nama',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text('NIP', style: TextStyle(fontSize: 20)),
                      SizedBox(
                        height: 20,
                      ),
                      Text('role', style: TextStyle(fontSize: 20)),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_city,
                            size: 30,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text('Lokasi Sekarang')
                        ],
                      ),
                    ],
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Container(
                height: 100,
                width: 400,
                decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
            Container(
                padding: EdgeInsets.all(13),
                alignment: Alignment.topLeft,
                child: Text('Absen 5 Hari Terakhir')),
            SizedBox(
              height: 7,
            ),
            ListView.builder(
              itemCount: 2,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Container(
                    height: 150,
                    width: 400,
                    decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
