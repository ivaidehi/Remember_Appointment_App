import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';

import '../styles/app_styles.dart';

class GetApptDate extends StatefulWidget {
  final Function(DateTime)? onDateSelected;

  const GetApptDate({
    super.key,
    this.onDateSelected,
  });

  @override
  State<GetApptDate> createState() => _GetApptDateState();
}

class _GetApptDateState extends State<GetApptDate> {
  final DateTime _todayDate = DateTime.now();
  final DateTime _maxDate = DateTime.now().add(const Duration(days: 5));

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 3),
            height: 100,
            decoration: AppStyles.inputBoxShadowStyle
        ),
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: DatePicker(
                DateTime.now(),
                height: 100,
                width: 80,
                initialSelectedDate: DateTime.now(),
                selectionColor: AppStyles.primary,
                selectedTextColor: Colors.white,
                dateTextStyle: AppStyles.headLineStyle3,
                onDateChange: (date) {
                  // Compare only the date parts
                  if (date.isBefore(DateTime(_todayDate.year, _todayDate.month, _todayDate.day)) ||
                      date.isAfter(_maxDate)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Please select a date within the next 5 days.')),
                    );
                  } else {
                    widget.onDateSelected!(date);
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
