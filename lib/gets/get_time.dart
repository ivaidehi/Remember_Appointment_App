import 'package:appointment_app/styles/app_styles.dart';
import 'package:flutter/material.dart';

class GetApptTime extends StatefulWidget {
  final String selectedTime;
  final ValueChanged<String> onTimeSelected;
  final bool isTimeSlotBlocked;
  final bool isTimeSlotBooked; // Add a new property to check if it's booked

  const GetApptTime({
    super.key,
    required this.selectedTime,
    required this.onTimeSelected,
    required this.isTimeSlotBlocked,
    required this.isTimeSlotBooked, // Accept the booked status
  });

  @override
  State<GetApptTime> createState() => _GetApptTimeState();
}

class _GetApptTimeState extends State<GetApptTime> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: widget.isTimeSlotBlocked || widget.isTimeSlotBooked
              ? null // If blocked or booked, disable the button.
              : () {
            widget.onTimeSelected(widget.selectedTime);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.isTimeSlotBlocked || widget.isTimeSlotBooked
                ? Colors.grey.shade800 // Change color when blocked or booked.
                : AppStyles.primary, // Default color when not blocked or booked.
          ),
          child: Text(
            widget.selectedTime,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
