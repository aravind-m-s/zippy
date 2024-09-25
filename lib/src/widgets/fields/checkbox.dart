import 'package:flutter/material.dart';
import 'package:zippy/src/controllers/bloc/zippyform_bloc.dart';
import 'package:zippy/src/core/app_colors.dart';
import 'package:zippy/src/models/checkbox.dart';

class CheckboxField extends StatefulWidget {
  final CheckboxModel field;
  final ZippyFormBloc bloc;
  const CheckboxField({super.key, required this.field, required this.bloc});
  @override
  State<CheckboxField> createState() => _CheckboxFieldState();
}

class _CheckboxFieldState extends State<CheckboxField> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(
        widget.field.options.length,
        (index) => Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Checkbox(
                activeColor: AppColors.zippyPrimaryColor,
                value: widget.bloc.checkboxValues[widget.field.fieldId]!
                    .contains(widget.field.options[index].value),
                onChanged: (value) {
                  if (widget.bloc.checkboxValues[widget.field.fieldId]!
                      .contains(widget.field.options[index].value)) {
                    widget.bloc.checkboxValues[widget.field.fieldId]!
                        .remove(widget.field.options[index].value);
                  } else {
                    if (widget.bloc.checkboxValues[widget.field.fieldId]!
                            .length >=
                        widget.field.validations.maxSelection) {
                      widget.bloc.checkboxValues[widget.field.fieldId]!
                          .removeAt(0);
                    }
                    widget.bloc.checkboxValues[widget.field.fieldId]!
                        .add(widget.field.options[index].value);
                  }

                  setState(() {});
                },
              ),
              Text(
                widget.field.options[index].label,
                style: const TextStyle(
                  fontSize: 16,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
