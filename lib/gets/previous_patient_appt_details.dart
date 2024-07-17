import 'package:flutter/cupertino.dart';
import '../myWidgets/line_widget.dart';
import '../styles/app_styles.dart';

class PreviousPatientApptDetails extends StatelessWidget {

  final String previous_appt_date;
  final String schedule_treatment;
  final String note;

  const PreviousPatientApptDetails({super.key, required this.previous_appt_date, required this.schedule_treatment, required this.note});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Previous Appointment Date : ',
                style: AppStyles.headLineStyle2_0.copyWith(
                    fontWeight: FontWeight.bold, color: AppStyles.secondary
                ),
              ),
              TextSpan(
                text: previous_appt_date,
                style: AppStyles.headLineStyle2_0.copyWith(color: AppStyles.primary),
              ),
            ],
          ),
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 15, width: 400,),
        const LineWidget(),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Scheduled Treatment : ',
                style: AppStyles.headLineStyle2_0.copyWith(
                    fontWeight: FontWeight.bold, color: AppStyles.secondary
                ),
              ),
              TextSpan(
                text: schedule_treatment,
                style: AppStyles.headLineStyle2_0.copyWith(color: AppStyles.primary),
              ),
            ],
          ),
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 15, width: 400,),
        const LineWidget(),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Note : ',
                style: AppStyles.headLineStyle2_0.copyWith(
                    fontWeight: FontWeight.bold, color: AppStyles.secondary
                ),
              ),
              TextSpan(
                text: note,
                style: AppStyles.headLineStyle2_0.copyWith(color: AppStyles.primary),
              ),
            ],
          ),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }
}
