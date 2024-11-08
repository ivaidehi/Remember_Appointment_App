import 'package:flutter/material.dart';
import '../styles/app_styles.dart';

class SubHeadingWidget extends StatelessWidget {
  final String subHeading;
  const SubHeadingWidget({super.key, required this.subHeading});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(subHeading,
              style: AppStyles.headLineStyle4),
        ),
        Transform.rotate(
            angle: 1.5,
            child: Icon(
              Icons.arrow_forward_ios,
              color: AppStyles.secondary,
              size: 20,
            ))
      ],
    );
  }
}
