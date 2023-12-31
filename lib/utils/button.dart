import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.enabled = true,
    this.label,
    this.child,
    this.onTap,
  });
  final bool enabled;
  final Widget? child;
  final String? label;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: enabled ? Colors.green : Colors.black26,
          boxShadow: enabled
              ? [
                  BoxShadow(
                      spreadRadius: 1,
                      blurRadius: 8,
                      color: Colors.black.withOpacity(0.2))
                ]
              : null,
          borderRadius: BorderRadius.circular(12.0),
        ),
        height: 50,
        width: double.maxFinite,
        child: Center(
          child: label != null
              ? Text(
                  label!,
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )
              : child,
        ),
      ),
    );
  }
}
