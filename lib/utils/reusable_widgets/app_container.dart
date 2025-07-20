import 'package:flutter/material.dart';
import 'package:shops2/utils/constants/app_colors.dart';

class AppContainer extends StatelessWidget {
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BoxDecoration? decoration;
  final AlignmentGeometry? alignment;
  final double? width;
  final double? height;
  final Color? color;

  const AppContainer({
    Key? key,
    this.child,
    this.padding,
    this.margin,
    this.decoration,
    this.alignment,
    this.width,
    this.height,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    if (child == null &&
        (width != null || height != null) &&
        padding == null &&
        margin == null &&
        decoration == null &&
        alignment == null &&
        color == null) {
      return SizedBox(width: width, height: height);
    }
    if (color != null &&
        padding == null &&
        margin == null &&
        decoration == null &&
        alignment == null &&
        width == null &&
        height == null) {
      return ColoredBox(
        color: color ?? AppColors.background,
        child: child ?? const SizedBox.shrink(),
      );
    }
    return Container(
      padding: padding,
      margin: margin,
      decoration:
          decoration ?? (color != null ? BoxDecoration(color: color) : null),
      alignment: alignment,
      width: width,
      height: height,
      child: child,
    );
  }
}
