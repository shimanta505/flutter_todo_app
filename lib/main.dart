import 'package:flutter/material.dart';
import 'package:flutter_todo/db/dbHelper.dart';
import 'package:flutter_todo/home_screen.dart';
import 'package:flutter_todo/services/theme_services.dart';
import 'package:flutter_todo/ui/theme.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper.initDb();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeServices().theme,
      home: const HomeScreen(),
    );
  }
}
