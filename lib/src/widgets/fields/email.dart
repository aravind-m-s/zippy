import 'package:flutter/material.dart';
import 'package:zippy/src/controllers/bloc/zippyform_bloc.dart';

import 'package:zippy/src/models/email.dart';
import 'package:zippy/src/theme/text_input_decoration.dart';

class EmailField extends StatelessWidget {
  final EmailModel field;
  final ZippyFormBloc bloc;

  const EmailField({super.key, required this.field, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: bloc.controllers[field.fieldId],
      decoration: getInputDecoration(
        field,
        bloc,
      ),
    );
  }
}
