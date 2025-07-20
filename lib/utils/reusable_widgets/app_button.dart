import 'package:flutter/material.dart';
import '../extensions/app_text_extension.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final ButtonStyle? style;
  final Widget? icon;
  final Color? textColor;

  const AppButton({
    Key? key,
    required this.label,
    this.onPressed,
    this.style,
    this.icon,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (icon != null) {
      return ElevatedButton.icon(
        onPressed: onPressed,
        icon: icon!,
        label: label.subheading(color: textColor),
        style: style,
      );
    }
    return ElevatedButton(
      onPressed: onPressed,
      style: style,
      child: label.subheading(color: textColor),
    );
  }
}
