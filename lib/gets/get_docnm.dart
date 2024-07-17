import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../styles/app_styles.dart';

class GetDoctorfnm extends StatelessWidget {
  final String doctor_fname;

  const GetDoctorfnm({super.key, required this.doctor_fname});

  @override
  Widget build(BuildContext context) {
    return Text("Dr. $doctor_fname",
        style: AppStyles.headLineStyle1.copyWith(color: AppStyles.secondary));
  }
}
