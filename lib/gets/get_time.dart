import 'package:appointment_app/styles/app_styles.dart';
import 'package:flutter/material.dart';

class GetApptTime extends StatefulWidget {
  final String selectedTime;
  final ValueChanged<String> onTimeSelected;
  final bool isTimeSlotBlocked;
  final bool isTimeSlotBooked;
  final bool isTimeSlotTapped; // New property to check if the time slot is tapped

  const GetApptTime({
    super.key,
    required this.selectedTime,
    required this.onTimeSelected,
    required this.isTimeSlotBlocked,
    required this.isTimeSlotBooked,
    required this.isTimeSlotTapped, // Accept tapped state
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
              ? null // Disable the button if blocked or booked
              : () {
            widget.onTimeSelected(widget.selectedTime);
            setState(() {}); // Trigger UI update
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:(widget.isTimeSlotBlocked || widget.isTimeSlotBooked || widget.isTimeSlotTapped
                ? const Color(0xFFCAD5DE) // Change color when blocked or booked
                : AppStyles.primary), // Default color when not blocked or booked
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
