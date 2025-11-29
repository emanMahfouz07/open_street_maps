import 'package:flutter/material.dart';

class CustomCountryInfo extends StatelessWidget {
  const CustomCountryInfo({
    super.key,
    required this.label,
    required this.value,
  });
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "$label: ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 14,
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(color: Colors.black, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
