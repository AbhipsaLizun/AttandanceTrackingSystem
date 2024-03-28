import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';

class CustomErrorDialog extends StatelessWidget {
  final String title;
  final String message;

  CustomErrorDialog({required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.error,
            color: Colors.red, // You can customize the color
          ),
          SizedBox(height: 16.0), // Add some spacing
          Text(
            title,
            style: TextStyle(
              color: Colors.red, // You can customize the color
            ),
          ),
          SizedBox(height: 8.0), // Add some spacing
          Text(
            message,
            style: TextStyle(
              fontSize: 16.0,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.0), // Add some spacing
          Container(
            width: double.infinity,
            child: ElevatedButton(

              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ),
        ],
      ),
    );
  }


}
