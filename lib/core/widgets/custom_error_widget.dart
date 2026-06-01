import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  final String message;
  const CustomErrorWidget({super.key, this.message = 'An error occurred'});

  @override
  Widget build(BuildContext context) => Center(child: Text(message));
}
