import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {
  final String? text;
  final double width;
  final double height;
  final VoidCallback? onPressed;
  final Color color;
  final double borderRadius;
  final TextStyle? textStyle;
  final Widget? child;
  const CustomFilledButton.text(
      {super.key,
      this.height = 50,
      this.width = double.infinity,
      required this.text,
      this.onPressed,
      required this.color,
      this.borderRadius = 18,
      this.textStyle})
      : child = null;

  const CustomFilledButton.widget(
      {super.key,
      this.height = 50,
      this.width = double.infinity,
      required this.child,
      this.onPressed,
      required this.color,
      this.borderRadius = 18,
      this.textStyle})
      : text = null;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Material(
          color: color,
          child: InkWell(
            radius: borderRadius,
            onTap: onPressed,
            child: Center(
              child: text != null
                  ? Text(
                      text!,
                      style: textStyle,
                      textAlign: TextAlign.center,
                    )
                  : child,
            ),
          ),
        ),
      ),
    );
  }
}
