import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';

class CustomSuccessDialog2 extends StatelessWidget {
  final String message;

  CustomSuccessDialog2({ required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(

      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 48.0,
          ),
          SizedBox(height: 16.0), // Add some spacing
          SizedBox(height: 8.0), // Add some spacing
          Text(
            message,
            style: TextStyle(
              fontSize: 16.0,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.0), // Add some spacing
          // Container(
          //   width: double.infinity,
          //   child: ElevatedButton(
          //
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //     },
          //     child: Text('OK'),
          //   ),
          // ),
        ],
      ),
    );
  }
}
