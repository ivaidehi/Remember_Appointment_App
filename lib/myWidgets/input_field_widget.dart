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
  final bool isReadOnly;
  final bool isEnabled;

  final Widget? preffixIcon;

  InputFieldWidget({
    super.key,
    required this.defaultHintText,
    required this.controller,
    required this.requiredInput,
    this.hideText = false,
    this.suffixIcon,
    this.preffixIcon,
    this.showWarning,
    this.onlyInt,
    this.keyBoardType,
    this.isReadOnly = false,
    this.isEnabled = true, required ,

  });

  @override
  State<InputFieldWidget> createState() => _InputFieldWidgetState();
}

class _InputFieldWidgetState extends State<InputFieldWidget> {
  late FocusNode _focusNode;
  bool _isTapped = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    setState(() {
      _isTapped = _focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

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
          focusNode: _focusNode,
          validator: (value) {
            // Check if an explicit warning is set
            if (widget.showWarning != null && widget.showWarning!.isNotEmpty) {
              return widget.showWarning; // Display error message
            }

            // Check if the field is empty
            if (value == null || value.isEmpty) {
              return 'Please enter a valid ${widget.requiredInput}';
            }

            // If no errors, reset the warning
            return null;
          },
          onChanged: (value) {
            // Reset the error when the user starts typing
            setState(() {
              widget.showWarning = null;
            });
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
            disabledBorder: const OutlineInputBorder(
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
            fillColor: _isTapped
                ? Colors.grey.shade100 // Color when focused
                : Colors.white, // Default color
            suffixIcon: widget.suffixIcon,
            prefixIcon: widget.preffixIcon,
          ),
          inputFormatters: widget.onlyInt != null ? [widget.onlyInt!] : [],
          keyboardType: widget.keyBoardType,
          maxLines: widget.hideText ? 1 : null,
          minLines: 1,
          readOnly: widget.isReadOnly,
          enabled: widget.isEnabled,
        ),
      ],
    );
  }
}
