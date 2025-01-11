import 'package:flutter/material.dart';
import '../styles/app_styles.dart';
import '../myWidgets/line_widget.dart';

class WrappedApptView extends StatelessWidget {
  final Map<String, dynamic>? appointmentData;
  final VoidCallback? onDelete;
  final int index;

  const WrappedApptView({
    super.key,
    this.appointmentData,
    this.onDelete,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    // Safely extract fields as lists or parse them if they are strings
    final patientNames = _ensureList(appointmentData?['Patient Name']);
    final apptDates = _getLatestValueList(appointmentData?['Selected Date']);
    final apptTimes = _getLatestValueList(appointmentData?['Selected Time Slot']);

    // Handle empty data gracefully
    if (patientNames.isEmpty || apptDates.isEmpty || apptTimes.isEmpty) {
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
            // Patient Names & Delete Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    patientNames.join(", "),
                    style: AppStyles.headLineStyle3_0
                        .copyWith(color: AppStyles.primary),
                  ),
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
            // Appointment Dates & Times
            const SizedBox(height: 10),
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
                    Text(apptDates.isNotEmpty ? apptDates.last : "N/A"),
                    Text(apptTimes.isNotEmpty ? apptTimes.last : "N/A"),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to ensure the data is a list
  List<String> _ensureList(dynamic value) {
    if (value is List<dynamic>) {
      return value.cast<String>();
    } else if (value is String) {
      // Parse string to list if stored as a single concatenated string
      return value.split(',').map((e) => e.trim()).toList();
    }
    return [];
  }

  // Helper function to get the latest value as a list
  List<String> _getLatestValueList(dynamic value) {
    if (value is List<dynamic>) {
      return value.cast<String>();
    } else if (value is String) {
      // Only keep the last appended value
      final list = value.split(',').map((e) => e.trim()).toList();
      return list.isNotEmpty ? [list.last] : [];
    }
    return [];
  }
}
