import 'package:flutter/material.dart';

class LabelWidget extends StatelessWidget {
  final String label;
  final bool isRequired;
  const LabelWidget({
    super.key,
    required this.label,
    required this.isRequired,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(text: label, children: [
        if (isRequired)
          const TextSpan(
            text: "  *",
            style: TextStyle(
              color: Colors.red,
              fontSize: 16,
            ),
          )
      ]),
      style: const TextStyle(
        fontSize: 16,
      ),
    );
  }
}
