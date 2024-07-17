import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../styles/app_styles.dart';

class GetApptDateTime extends StatelessWidget {

  final String appt_date;
  final String appt_time;

  const GetApptDateTime({super.key,required this.appt_date, required this.appt_time});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(appt_date, style: AppStyles.headLineStyle3.copyWith(color: AppStyles.primary)),
        const SizedBox(height: 5),
        Text(appt_time, style: AppStyles.headLineStyle3.copyWith(color: AppStyles.primary))
      ],
    );
  }
}
