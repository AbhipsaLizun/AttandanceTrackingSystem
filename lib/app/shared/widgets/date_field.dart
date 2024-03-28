import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DateField extends StatelessWidget {
   DateField({super.key, required this.controller, required this.onTap});
  final TextEditingController controller;
  final Function()? onTap;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
      readOnly: true,
      textAlignVertical: TextAlignVertical.center,
      style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600, fontSize: 15),
      decoration:  InputDecoration(
          fillColor: Colors.grey[200],
          filled: true,
          hintText: "yyyy-MM-dd",
          contentPadding: const EdgeInsets.only(left: 10),
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none
          ),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none
          ),
          suffixIcon: const Icon(
            Icons.calendar_month,
            size: 18,
            color: Colors.grey,
          )),
      onTap: onTap,
      validator:(value) {
    if (value == null || value.isEmpty) {
    return "Please select date";
    }
    return null;
    }
    );
  }
}
