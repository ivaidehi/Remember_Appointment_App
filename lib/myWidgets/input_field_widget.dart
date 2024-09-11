import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../styles/app_styles.dart';

class InputFieldWidget extends StatefulWidget {
  final String defaultHintText;
  final String requiredInput;
  final bool hideText;
  final TextEditingController controller;
  String? showWarning;
  final Widget? suffixIcon;
  TextInputFormatter? onlyInt;
  TextInputType? keyBoardType;

  InputFieldWidget({
    super.key,
    required this.defaultHintText,
    required this.controller,
    required this.requiredInput,
    this.hideText = false,
    this.suffixIcon,
    this.showWarning,
    this.onlyInt,
    this.keyBoardType,
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
          height: 48,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: AppStyles.inputBoxShadowStyle,
        ),
        TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              setState(() {
                widget.showWarning =
                'Please enter a valid ${widget.requiredInput}';
              });
              return widget.showWarning;
            }
            setState(() {
              widget.showWarning = null; // Reset the warning if valid
            });
            return null;
          },
          obscureText: widget.hideText,
          controller: widget.controller,
          cursorColor: AppStyles.secondary,
          decoration: InputDecoration(
            hintText: widget.defaultHintText,
            hintStyle: const TextStyle(color: Colors.grey),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppStyles.secondary),
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1.5),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1.5),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            errorText: widget.showWarning,
            contentPadding: const EdgeInsets.symmetric(horizontal: 15),
            filled: true,
            fillColor: Colors.white,
            suffixIcon: widget.suffixIcon,
          ),
          inputFormatters: widget.onlyInt != null ? [widget.onlyInt!] : [],
          keyboardType: widget.keyBoardType,
          maxLines: widget.hideText ? 1 : null,
          minLines: 1,
        ),
      ],
    );
  }
}
