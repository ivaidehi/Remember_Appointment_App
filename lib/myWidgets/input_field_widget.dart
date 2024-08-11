import 'package:flutter/material.dart';
import '../styles/app_styles.dart';

class InputFieldWidget extends StatefulWidget {
  final String defaultHintText;
  final String requiredInput;
  final bool hideText;
  final TextEditingController controller;

  final Widget? suffixIcon;

  const InputFieldWidget({
    super.key,
    required this.defaultHintText,
    required this.controller,
    required this.requiredInput,
    this.hideText=false,
    this.suffixIcon,
  });

  @override
  State<InputFieldWidget> createState() => _InputFieldWidgetState();
}

class _InputFieldWidgetState extends State<InputFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 50,
          decoration: AppStyles.searchBoxStyle,
        ),
        TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a valid ${widget.requiredInput}';
            }
            return null;
          },
          obscureText: widget.hideText,
          controller: widget.controller,
          cursorColor: AppStyles.secondary,
          decoration: InputDecoration(
            hintText: widget.defaultHintText,
            hintStyle: const TextStyle(color: Colors.grey),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppStyles.tertiary, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppStyles.secondary),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1.5),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1.5),
            ),
            // border: ,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            filled: true,
            fillColor: Colors.white,
            suffixIcon: widget.suffixIcon,
          ),
        ),
      ],
    );
  }
}
