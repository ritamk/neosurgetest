import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> customSnackbar(
  BuildContext context, {
  required String content,
  bool? isError,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        content,
        style: TextStyle(
          fontFamily: GoogleFonts.montserrat().fontFamily,
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: isError != null
          ? isError
              ? Colors.red.shade800
              : Colors.green.shade800
          : Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
    ),
  );
}
