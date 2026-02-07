import 'package:anton_zyryanov_barcode_scanner/di_container.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

final DIContainer diContainer = DIContainer();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return diContainer.buildApp(context);
  }
}
