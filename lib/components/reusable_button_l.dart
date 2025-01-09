import 'package:flutter/material.dart';

class ReusableButtonL extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color backgroundColor;
  final double borderRadius;
  final TextStyle textStyle;

  const ReusableButtonL({
    super.key,
    required this.text,
    required this.onTap,
    this.backgroundColor = Colors.black, // Default to a blue shade
    this.borderRadius = 10.0,
    this.textStyle = const TextStyle(
        color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.5,
      child: Material(
        borderRadius: BorderRadius.circular(borderRadius),
        elevation: 5.0,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Center(
              child: Text(
                text,
                style: textStyle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
