import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('data'),
      ),
      body: const Center(
        child: Text(
          'data',
          style: TextStyle(
              fontWeight: FontWeight.w700, color: Colors.black, fontSize: 26),
        ),
      ),
    );
  }
}
