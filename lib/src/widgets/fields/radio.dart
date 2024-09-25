import 'package:flutter/material.dart';
import 'package:zippy/src/controllers/bloc/zippyform_bloc.dart';
import 'package:zippy/src/core/app_colors.dart';
import 'package:zippy/src/models/radio.dart';

class RadioField extends StatefulWidget {
  final RadioModel field;
  final ZippyFormBloc bloc;

  const RadioField({super.key, required this.field, required this.bloc});

  @override
  State<RadioField> createState() => _RadioFieldState();
}

class _RadioFieldState extends State<RadioField> {
  @override
  void initState() {
    super.initState();
    widget.bloc.radioValues[widget.field.fieldId] =
        widget.field.options.first.value;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(
        widget.field.options.length,
        (index) => GestureDetector(
          onTap: () {
            widget.bloc.radioValues[widget.field.fieldId] =
                widget.field.options[index].value;
            setState(() {});
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Radio.adaptive(
                activeColor: AppColors.zippyPrimaryColor,
                value: widget.field.options[index].value,
                groupValue: widget.bloc.radioValues[widget.field.fieldId],
                onChanged: (value) {
                  widget.bloc.radioValues[widget.field.fieldId] =
                      widget.field.options[index].value;
                  setState(() {});
                },
              ),
              Flexible(
                child: Text(
                  widget.field.options[index].label,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
