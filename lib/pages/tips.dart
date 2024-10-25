import 'package:flutter/material.dart';

class Tips extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tips',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(height: 30),
          Image.asset(
            'assets/image/tips_image1.avif',
            width: 250,
            height: 250,
            fit: BoxFit.contain,
          ),
   ] 
    )
    );
  }
}