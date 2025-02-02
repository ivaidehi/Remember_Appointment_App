import 'package:flutter/cupertino.dart';
import '../myWidgets/line_widget.dart';
import '../styles/app_styles.dart';

class PreviousPatientApptDetails extends StatelessWidget {
  final String previousApptDate;
  final String scheduleTreatment;
  final String note;

  const PreviousPatientApptDetails({
    super.key,
    required this.previousApptDate,
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
                text: 'Previous Appointment Date: ',
                style: AppStyles.headLineStyle2_0.copyWith(
                    fontWeight: FontWeight.bold, color: AppStyles.secondary),
              ),
              TextSpan(
                text: previousApptDate.isNotEmpty ? previousApptDate : "N/A",
                style: AppStyles.headLineStyle2_0.copyWith(
                    color: AppStyles.primary),
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
                style: AppStyles.headLineStyle2_0.copyWith(
                    fontWeight: FontWeight.bold, color: AppStyles.secondary),
              ),
              TextSpan(
                text: scheduleTreatment.isNotEmpty ? scheduleTreatment : "N/A",
                style: AppStyles.headLineStyle2_0.copyWith(
                    color: AppStyles.primary),
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
                style: AppStyles.headLineStyle2_0.copyWith(
                    fontWeight: FontWeight.bold, color: AppStyles.secondary),
              ),
              TextSpan(
                text: note.isNotEmpty ? note : "N/A",
                style: AppStyles.headLineStyle2_0.copyWith(
                    color: AppStyles.primary),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
