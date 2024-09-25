import 'package:flutter/material.dart';
import 'package:zippy/src/controllers/bloc/zippyform_bloc.dart';

import 'package:zippy/src/models/website.dart';
import 'package:zippy/src/theme/text_input_decoration.dart';

class WebsiteField extends StatelessWidget {
  final WebsiteModel field;
  final ZippyFormBloc bloc;

  const WebsiteField({super.key, required this.field, required this.bloc});

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
