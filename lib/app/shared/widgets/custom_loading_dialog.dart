import 'package:flutter/material.dart';

class CustomLoadingDialog extends StatelessWidget {
  final String message;

  const CustomLoadingDialog({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 5.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16.0),
              Text(
                message,
                style: const TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}