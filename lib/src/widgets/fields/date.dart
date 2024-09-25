import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zippy/src/controllers/bloc/zippyform_bloc.dart';

import 'package:zippy/src/models/date.dart';
import 'package:zippy/src/theme/text_input_decoration.dart';

class DateField extends StatefulWidget {
  final DateModel field;
  final ZippyFormBloc bloc;
  const DateField({super.key, required this.field, required this.bloc});

  @override
  State<DateField> createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      controller: TextEditingController(
        text: widget.bloc.dateTimeValues[widget.field.fieldId] == null
            ? ""
            : DateFormat(widget.field.validations.dateFormat == "d-m-y"
                    ? "dd-MM-yyyy"
                    : "MM-dd-yyyy")
                .format(
                widget.bloc.dateTimeValues[widget.field.fieldId]!,
              ),
      ),
      onTap: () async {
        final pickedDate = await showDatePicker(
          context: context,
          firstDate: DateTime(2000),
          lastDate: DateTime(2500),
          initialDate: widget.bloc.dateTimeValues[widget.field.fieldId] ??
              DateTime.now(),
        );
        if (pickedDate != null) {
          widget.bloc.dateTimeValues[widget.field.fieldId] = pickedDate;
        }
        setState(() {});
      },
      decoration: getInputDecorationWithoutFieldFormat(
        widget.field,
        widget.bloc,
      ),
    );
  }
}
