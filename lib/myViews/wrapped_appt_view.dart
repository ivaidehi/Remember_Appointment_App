import 'package:flutter/material.dart';
import '../gets/get_date_time.dart';
import '../gets/get_patientnm_pid.dart';
import '../styles/app_styles.dart';
import '../myWidgets/line_widget.dart';

class WrappedApptView extends StatelessWidget {
  final Map<String,dynamic> wrappedAppt;
  const WrappedApptView({super.key, required this.wrappedAppt});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: AppStyles.searchBoxStyle,
      // Patient's name & pid
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GetPatientnmPid(patient_name: wrappedAppt["pname"], pid: wrappedAppt["pid"]),
            const LineWidget(),
            // Date & Time
            Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Date", style: AppStyles.headLineStyle3),
                    const SizedBox(height: 5),
                    Text("Time", style: AppStyles.headLineStyle3,),
                  ],
                ),
                GetApptDateTime(appt_date: wrappedAppt["appt_date_time"]["date"], appt_time: wrappedAppt["appt_date_time"]["time"]),
              ],
            )
          ],
        ),
      ),
    );
  }
}
