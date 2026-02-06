import 'package:flutter/material.dart';

class SneakerLoaderWidget extends StatelessWidget {
  const SneakerLoaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Image.asset(
          'assets/sneaker_loader.gif',
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
