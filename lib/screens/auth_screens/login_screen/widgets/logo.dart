import 'package:flutter/material.dart';

class CompanyLogo extends StatelessWidget {
  const CompanyLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Image.asset('assets/Company Name.png', width: 350, height: 265),
    );
  }
}
