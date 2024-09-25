import 'package:flutter/material.dart';
import 'package:zippy/src/core/app_utils.dart';
import 'package:zippy/src/models/paragraph.dart';

class ParagraphField extends StatelessWidget {
  final ParagraphModel field;
  const ParagraphField({super.key, required this.field});

  @override
  Widget build(BuildContext context) {
    return Text(
      field.content,
      style: TextStyle(
        fontSize: AppUtils.getFontSizeForStaticFields(
          field.contentSize,
        ).toDouble(),
      ),
    );
  }
}
