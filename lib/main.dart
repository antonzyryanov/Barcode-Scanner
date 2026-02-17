import 'package:anton_zyryanov_barcode_scanner/di_container.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final DIContainer diContainer = await DIContainer.create();
  runApp(MyApp(diContainer: diContainer));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.diContainer});

  final DIContainer diContainer;

  @override
  Widget build(BuildContext context) {
    return diContainer.buildApp(context);
  }
}
