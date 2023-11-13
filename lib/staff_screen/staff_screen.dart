import 'package:flutter/material.dart';

class staff extends StatefulWidget {
  const staff({super.key});

  @override
  State<staff> createState() => _staffState();
}

class _staffState extends State<staff> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Staff'),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(13.0),
            child: Container(
              height: 200,
              width: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.redAccent,
              ),
              child: Image.asset(
                'assets/images/logo.jpg',
                height: 10,
                width: 10,
              ),
            ),
          );
        },
      ),
    );
  }
}
