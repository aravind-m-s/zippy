import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zippy/src/controllers/bloc/zippyform_bloc.dart';

import 'package:zippy/src/models/phone_number_field.dart';
import 'package:zippy/src/theme/text_input_decoration.dart';

class PhoneField extends StatelessWidget {
  final PhoneModel field;
  final ZippyFormBloc bloc;

  const PhoneField({super.key, required this.field, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: bloc.controllers[field.fieldId],
      maxLength: field.validations.maxlength,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: getInputDecoration(
        field,
        bloc,
      ),
    );
  }
}
