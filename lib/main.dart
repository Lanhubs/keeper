import 'package:flutter/material.dart';
import "package:get/get.dart";
import 'package:keeper/constants/utils.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:toastification/toastification.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox("keeperBox");
  await Hive.openBox("Settings");
  await Hive.openBox("Invoices");
  await Hive.openBox("Clients");
  await Hive.openBox("expenses");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: GetMaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF1E90FF)),
          useMaterial3: true,
        ),
        getPages: AppRoutes.pages,
        initialRoute: AppRoutes.splash,
      ),
    );
  }
}
