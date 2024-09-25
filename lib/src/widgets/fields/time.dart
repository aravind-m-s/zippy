import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zippy/src/controllers/bloc/zippyform_bloc.dart';

import 'package:zippy/src/models/time.dart';
import 'package:zippy/src/theme/text_input_decoration.dart';

class TimeField extends StatefulWidget {
  final TimeModel field;
  final ZippyFormBloc bloc;
  const TimeField({super.key, required this.field, required this.bloc});

  @override
  State<TimeField> createState() => _TimeFieldState();
}

class _TimeFieldState extends State<TimeField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      controller: TextEditingController(
        text: widget.bloc.dateTimeValues[widget.field.fieldId] == null
            ? ""
            : DateFormat(widget.field.validations.timeFormat == "24"
                    ? "HH:mm"
                    : "hh:mm a")
                .format(
                widget.bloc.dateTimeValues[widget.field.fieldId]!,
              ),
      ),
      onTap: () async {
        final pickedTime = await showTimePicker(
          context: context,
          builder: (context, childWidget) {
            return MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: childWidget!,
            );
          },
          initialEntryMode: widget.field.validations.timeFormat == "24"
              ? TimePickerEntryMode.input
              : TimePickerEntryMode.dial,
          initialTime: TimeOfDay.fromDateTime(
            widget.bloc.dateTimeValues[widget.field.fieldId] ?? DateTime.now(),
          ),
        );
        if (pickedTime != null) {
          widget.bloc.dateTimeValues[widget.field.fieldId] =
              DateTime(0, 0, 0, pickedTime.hour, pickedTime.minute);
        }
        setState(() {});
      },
      decoration:
          getInputDecorationWithoutFieldFormat(widget.field, widget.bloc),
    );
  }
}
