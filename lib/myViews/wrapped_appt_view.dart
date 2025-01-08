import 'package:flutter/material.dart';
import '../styles/app_styles.dart';
import '../myWidgets/line_widget.dart';

class WrappedApptView extends StatelessWidget {
  Map<String, dynamic>? appointmentData;
  VoidCallback? onDelete;
  final int index;

  WrappedApptView({
    super.key,
    this.appointmentData,
    this.onDelete, required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final patientName = appointmentData?['Patient Name'];
    final apptDate = appointmentData?['Selected Date'];
    final apptTime = appointmentData?['Selected Time Slot'];

    if (patientName == null || apptDate == null || apptTime == null) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      decoration: AppStyles.inputBoxShadowStyle.copyWith(color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Patient Name & Delete Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(patientName,
                      style: AppStyles.headLineStyle3_0
                          .copyWith(color: AppStyles.primary)),
                ),
                GestureDetector(
                  onTap: onDelete,
                  child: Text(
                    "Delete",
                    style: TextStyle(
                      color: AppStyles.primary,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            const LineWidget(),
            // Appointment Date & Time
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Date", style: AppStyles.headLineStyle3),
                    Text("Time", style: AppStyles.headLineStyle3),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(apptDate),
                    Text(apptTime),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
