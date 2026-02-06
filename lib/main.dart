import 'package:anton_zyryanov_barcode_scanner/di_container.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final DIContainer diContainer = DIContainer();

  @override
  Widget build(BuildContext context) {
    return diContainer.buildApp(context);
  }
}
