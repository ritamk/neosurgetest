import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeInfoDialog extends StatelessWidget {
  const HomeInfoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text('Info',
          style: TextStyle(fontFamily: GoogleFonts.montserrat().fontFamily)),
      content: Center(
        child: Text(
            'Hey there! this is my submission for the assessment at '
            'Neosurge.\n\n'
            'If you\'re reading this, I hope you like what you see. I could not '
            'find enough time to work on it, so it\'s extremely bare-bones. '
            'The main culprit however was BLoC, I\'m just too used to Riverpod.\n'
            'Regardless, hello new teammate (hopefully)!',
            style: TextStyle(fontFamily: GoogleFonts.montserrat().fontFamily)),
      ),
    );
  }
}
