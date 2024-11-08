import 'package:flutter/material.dart';
import '../gets/get_patientnm_pid.dart';
import '../styles/app_styles.dart';
import '../myWidgets/line_widget.dart';

class WrappedApptView extends StatefulWidget {
  final Map<String, dynamic> wrappedAppt;
  VoidCallback? onDelete;
  WrappedApptView({super.key, required this.wrappedAppt, this.onDelete});

  @override
  State<WrappedApptView> createState() => _WrappedApptViewState();
}

class _WrappedApptViewState extends State<WrappedApptView> {
  late DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      decoration: AppStyles.inputBoxShadowStyle.copyWith(color: Colors.white),
      // Patient's name & pid
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GetPatientnmPid(patient_name: widget.wrappedAppt["pname"]),
                GestureDetector(
                    onTap: widget.onDelete,
                    child: Text(
                      "Delete",
                      style: TextStyle(
                          color: AppStyles.primary,
                          decoration: TextDecoration.underline),
                    ))
              ],
            ),
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
                    Text(
                      "Time",
                      style: AppStyles.headLineStyle3,
                    ),
                  ],
                ),
                // GetApptDateTime(onDateSelected: (date){
                //   setState(() {
                //     selectedDate = date;
                //   });
                // }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
