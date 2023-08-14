import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomModalSheet extends StatelessWidget {
  BottomModalSheet({super.key});

  final style = GoogleFonts.roboto(
      fontWeight: FontWeight.w400, fontSize: 16, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16.0),
        topRight: Radius.circular(16.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(
                'Product Designer',
                style: style,
              ),
              onTap: () {
                Navigator.pop(context, 'Product Designer');
              },
            ),
            ListTile(
              title: Text(
                'Flutter Developer',
                style: style,
              ),
              onTap: () {
                Navigator.pop(context, 'Flutter Developer');
              },
            ),
            ListTile(
              title: Text(
                'QA Tester',
                style: style,
              ),
              onTap: () {
                Navigator.pop(context, 'QA Tester');
              },
            ),
            ListTile(
              title: Text(
                'Product Owner',
                style: style,
              ),
              onTap: () {
                Navigator.pop(context, 'Product Owner');
              },
            ),
          ],
        ),
      ),
    );
  }
}
