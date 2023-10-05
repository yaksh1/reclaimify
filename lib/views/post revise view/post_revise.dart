import 'dart:typed_data';

import 'package:flutter/material.dart';

class PostReviseView extends StatelessWidget {
  const PostReviseView({super.key, required this.file});
  final Uint8List file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image:DecorationImage(image: MemoryImage(file),),),
          
        ),
      ),
    );
  }
}
