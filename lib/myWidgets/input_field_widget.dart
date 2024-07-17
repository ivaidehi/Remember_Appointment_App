import 'package:flutter/material.dart';
import '../styles/app_styles.dart';

class InputFieldWidget extends StatefulWidget {

  final String defaultHintText;
  TextEditingController controller = TextEditingController();
  InputFieldWidget({super.key, required this.defaultHintText, required this.controller});

  @override
  State<InputFieldWidget> createState() => _InputFieldWidgetState();
}

class _InputFieldWidgetState extends State<InputFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppStyles.searchBoxStyle,
      height: 50,
      child: TextField(
        controller: widget.controller,
        cursorColor: AppStyles.secondary,
        decoration: InputDecoration(
          hintText: widget.defaultHintText,
          // hintStyle: TextStyle(color : Colors.lightBlue[300],),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppStyles.secondary)),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
