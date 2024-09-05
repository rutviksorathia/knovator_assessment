import 'package:flutter/material.dart';
import 'package:flutter_task/app/app.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('postList');
  runApp(const MyApp());
}
