import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_app/screens/my-home/My_Home_Screen.dart';

class MyTeamScreen extends StatefulWidget {
  const MyTeamScreen({super.key});

  @override
  State<MyTeamScreen> createState() => _MyTeamScreenState();
}

class _MyTeamScreenState extends State<MyTeamScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 10),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => const MyHomeScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 20.0),
        padding: const EdgeInsets.only(top: 200.0),
        decoration: const BoxDecoration(color: Colors.white),
        child: const Column(
          children: <Widget>[
            Text("Giới thiệu nhóm 3",
                textDirection: TextDirection.ltr,
                style: TextStyle(fontSize: 20, color: Colors.black)),
            SizedBox(height: 20),
            Text("Nguyễn Đình Quang Huy - 20110494",
                textDirection: TextDirection.ltr,
                style: TextStyle(fontSize: 20, color: Colors.black)),
            SizedBox(height: 20),
            Text("Trần Thanh Huệ - 20110490",
                textDirection: TextDirection.ltr,
                style: TextStyle(fontSize: 20, color: Colors.black))
          ],
        ));
  }
}
