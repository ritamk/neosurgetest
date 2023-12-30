import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.focus,
    required this.controller,
    this.validation,
    this.inputAction,
    this.keyboardType,
    this.maxLength,
    this.minLines,
    this.maxLines,
    this.expands,
    this.label,
    this.hint,
    this.prefix,
    this.prefixText,
    this.suffix,
    this.suffixText,
    this.formatters = const [],
    this.readOnly = false,
    this.onTap,
    this.onChanged,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.obscure = false,
  });

  final FocusNode focus;
  final TextEditingController controller;
  final String? Function(String? value)? validation;
  final TextInputAction? inputAction;
  final TextInputType? keyboardType;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final bool? expands;
  final String? label;
  final String? hint;
  final Widget? prefix;
  final String? prefixText;
  final Widget? suffix;
  final String? suffixText;
  final List<TextInputFormatter> formatters;
  final bool readOnly;
  final void Function()? onTap;
  final void Function(String? value)? onChanged;
  final void Function(String? value)? onFieldSubmitted;
  final void Function()? onEditingComplete;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscure,
      focusNode: focus,
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: formatters,
      maxLength: maxLength,
      maxLengthEnforcement: maxLength != null
          ? MaxLengthEnforcement.enforced
          : MaxLengthEnforcement.none,
      minLines: minLines,
      maxLines: maxLines,
      expands: expands ?? false,
      textAlignVertical: TextAlignVertical.top,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.black.withOpacity(0.06),
        alignLabelWithHint: true,
        labelText: label,
        hintText: hint,
        prefixText: prefixText,
        suffixText: suffixText,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
          borderSide: BorderSide.none,
        ),
        prefixIcon: prefix,
        suffixIcon: suffix,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      ),
      readOnly: readOnly,
      textInputAction: inputAction,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validation,
      onTapOutside: (event) => focus.unfocus(),
      onTap: onTap,
      onChanged: (value) => onChanged,
      onFieldSubmitted: onFieldSubmitted,
      onEditingComplete: onEditingComplete,
    );
  }
}
