import 'package:flutter/material.dart';
import 'package:zippy/src/controllers/bloc/zippyform_bloc.dart';

import 'package:zippy/src/core/validations.dart';
import 'package:zippy/src/models/textfield.dart';
import 'package:zippy/src/theme/text_input_decoration.dart';

class TextFieldWidget extends StatelessWidget {
  final TextFieldModel field;
  final ZippyFormBloc bloc;

  const TextFieldWidget({super.key, required this.field, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: bloc.controllers[field.fieldId],
      validator: (value) => FieldValidations.validateTextField(
        fieldName: field.label,
        value: value ?? "",
        validations: field.validations,
      ),
      maxLength: field.validations.maxlength,
      decoration: getInputDecoration(field, bloc),
    );
  }
}
