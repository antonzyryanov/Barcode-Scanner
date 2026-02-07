import 'package:anton_zyryanov_barcode_scanner/di_container.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final DIContainer diContainer = DIContainer();
    return diContainer.buildApp(context);
  }
}
