import 'package:flutter/material.dart';
import '../myWidgets/line_widget.dart';
import '../styles/app_styles.dart';

class CurrentPatientApptDetails extends StatelessWidget {
  final String contact;
  final String scheduleTreatment;
  final String note;

  const CurrentPatientApptDetails({
    super.key,
    required this.contact,
    required this.scheduleTreatment,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Contact : ',
                style: AppStyles.headLineStyle3_0.copyWith(
                  // fontWeight: FontWeight.bold,
                  color: AppStyles.secondary,
                ),
              ),
              TextSpan(
                text: contact,
                style: AppStyles.headLineStyle3.copyWith(
                  color: AppStyles.primary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        const LineWidget(),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Scheduled Treatment: ',
                style: AppStyles.headLineStyle3_0.copyWith(
                  // fontWeight: FontWeight.bold,
                  color: AppStyles.secondary,
                ),
              ),
              TextSpan(
                text: scheduleTreatment,
                style: AppStyles.headLineStyle3.copyWith(
                  color: AppStyles.primary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        const LineWidget(),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Note: ',
                style: AppStyles.headLineStyle3_0.copyWith(
                  // fontWeight: FontWeight.bold,
                  color: AppStyles.secondary,
                ),
              ),
              TextSpan(
                text: note,
                style: AppStyles.headLineStyle3.copyWith(
                  color: AppStyles.primary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
