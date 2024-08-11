import 'package:flutter/cupertino.dart';

import '../styles/app_styles.dart';

class LabelsWidget extends StatelessWidget {
  final String label;
  const LabelsWidget({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "$label ",
          style: AppStyles.headLineStyle3.copyWith(color: AppStyles.primary),
        ),
        const SizedBox(
          height: 13,
        ),
      ],
    );
  }
}
