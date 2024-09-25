import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zippy/src/controllers/bloc/zippyform_bloc.dart';

import 'package:zippy/src/models/number_field.dart';
import 'package:zippy/src/theme/text_input_decoration.dart';

class NumberField extends StatelessWidget {
  final NumberFieldModel field;
  final ZippyFormBloc bloc;
  const NumberField({super.key, required this.field, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: bloc.controllers[field.fieldId],
      keyboardType: TextInputType.numberWithOptions(
        decimal: !field.validations.decimal,
      ),
      inputFormatters: [
        !field.validations.decimal
            ? DecimalPointFormatter()
            : FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: getInputDecoration(
        field,
        bloc,
      ),
    );
  }
}

class DecimalPointFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (double.tryParse(newValue.text) == null && newValue.text.isNotEmpty) {
      return oldValue;
    } else {
      return newValue;
    }
  }
}
