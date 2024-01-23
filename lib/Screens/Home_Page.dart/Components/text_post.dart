import 'package:flutter/material.dart';

class TextPost extends StatelessWidget {
  const TextPost({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(text),
    );
  }
}
