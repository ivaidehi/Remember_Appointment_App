// date_picker_widget.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../styles/app_styles.dart';

class CalendarWidget extends StatelessWidget {
  final TextEditingController dateController;
  final DateTime? selectedDate;
  final Function(DateTime?) onDateSelected;

  const CalendarWidget({super.key, 
    required this.dateController,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 3),
          height: 48,
          decoration: AppStyles.inputBoxShadowStyle,
        ),
        TextFormField(
          controller: dateController,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: selectedDate != null
                ? DateFormat.yMMMMd().format(selectedDate!)
                : DateFormat.yMMMMd().format(DateTime.now()),
            suffixIcon: GestureDetector(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: selectedDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );

                if (pickedDate != null) {
                  onDateSelected(pickedDate);
                }
              },
              child: Icon(Icons.calendar_today, color: AppStyles.primary), // Calendar icon
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 17),
          ),
          readOnly: true,
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: selectedDate ?? DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );

            if (pickedDate != null) {
              onDateSelected(pickedDate);
            }
          },
        ),
      ],
    );
  }
}
