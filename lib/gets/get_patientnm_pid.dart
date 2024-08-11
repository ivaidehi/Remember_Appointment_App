import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../styles/app_styles.dart';

class GetPatientnmPid extends StatelessWidget {

  final String patient_name;
  final int pid;

  const GetPatientnmPid({super.key,required this.patient_name, required this.pid});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(patient_name,
            style: AppStyles.headLineStyle3_0
                .copyWith(color: AppStyles.primary)),
        Text("PID: $pid",
            style: AppStyles.headLineStyle3_0
                .copyWith(color: AppStyles.primary)),
      ],
    );
  }
}
