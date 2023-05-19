import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetHomeScreen extends StatefulWidget {
  const GetHomeScreen({super.key});

  @override
  State<GetHomeScreen> createState() => _GetHomeScreenState();
}

class _GetHomeScreenState extends State<GetHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("get home"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.snackbar("wellcome", "hello",
              backgroundColor: Colors.green, maxWidth: 200);
        },
        child: const Icon(Icons.hdr_plus),
      ),
      body: const Column(
        children: [],
      ),
    );
  }
}
