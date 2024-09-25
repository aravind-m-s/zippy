import 'package:flutter/material.dart';
import 'package:zippy/src/core/app_utils.dart';
import 'package:zippy/src/models/heading.dart';

class HeadingField extends StatelessWidget {
  final HeadingModel field;
  const HeadingField({super.key, required this.field});

  @override
  Widget build(BuildContext context) {
    return Text(
      field.content,
      style: TextStyle(
        fontSize: AppUtils.getFontSizeForStaticFields(
          field.contentSize,
        ).toDouble(),
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
