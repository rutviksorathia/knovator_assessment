import 'package:flutter/material.dart';
import 'package:flutter_task/ui/views/home/home_view.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'Knovator Task',
      debugShowCheckedModeBanner: false,
      home: HomeView(),
    );
  }
}
