import 'package:flutter/material.dart';

import '../../../../shared/constants/color_constants.dart';

class CustomGridItem extends StatelessWidget {
  final String title;
  final String imageUrl;

  const CustomGridItem(
      {super.key, required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Stack(
          children: [
            // Background Image
            Image.asset(
              imageUrl,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),

            // Gradient Background for Text Container
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      LightColor.bgPrimary.withOpacity(0.0),
                      // Transparent at the top
                      LightColor.bgPrimary,
                      // Semi-transparent at the bottom
                    ],
                  ),
                ),
                child: Container(
                  color: Colors.transparent, // Transparent background for text
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
