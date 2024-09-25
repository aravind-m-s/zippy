import 'package:flutter/material.dart';
import 'package:zippy/src/controllers/bloc/zippyform_bloc.dart';

import 'package:zippy/src/models/text_area.dart';
import 'package:zippy/src/theme/text_input_decoration.dart';

class TextAreaField extends StatelessWidget {
  final TextAreaModel field;
  final ZippyFormBloc bloc;

  const TextAreaField({super.key, required this.field, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: bloc.controllers[field.fieldId],
      minLines: field.lines,
      maxLines: field.lines,
      maxLength: field.validations.maxlength,
      decoration: getAreaInputDecoration(field, bloc),
    );
  }
}
