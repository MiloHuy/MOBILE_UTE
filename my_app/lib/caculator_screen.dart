import 'package:flutter/material.dart';

class CaculatorScreen extends StatefulWidget {
  const CaculatorScreen({super.key});

  @override
  State<CaculatorScreen> createState() => _CaculatorScreenState();
}

class _CaculatorScreenState extends State<CaculatorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            bottom: false,
            child: Column(
              children: [
                // output
                Expanded(
                    child: SingleChildScrollView(
                  child: Container(
                    alignment: Alignment.bottomRight,
                    padding: const EdgeInsets.all(16),
                    child: const Text(
                      '0000000000000000',
                      style:
                          TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )),
              ],
            )));
  }
}
