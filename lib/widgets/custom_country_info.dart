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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "$label: ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: theme.textTheme.bodyLarge?.color,
              fontSize: 14,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              color: theme.textTheme.bodyMedium?.color,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
