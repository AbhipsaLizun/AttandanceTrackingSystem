import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmployeeData extends StatelessWidget {
  final String count;
  final String category;
  final Color countClr;
  final Color catClr;
  const EmployeeData({super.key, required this.count, required this.category, required this.countClr, required this.catClr});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Text(category,
        style: GoogleFonts.poppins(
          color: catClr,
          fontSize: 14,
          fontWeight: FontWeight.w600
        ),
        ),
        Text(count,
          style: GoogleFonts.poppins(
              color: countClr,
              fontSize: 25,
              fontWeight: FontWeight.w500
          ),
        ),
      ],
    );
  }
}