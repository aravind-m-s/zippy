import 'package:flutter/widgets.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:zippy/src/controllers/bloc/zippyform_bloc.dart';
import 'package:zippy/src/models/dropdown.dart';
import 'package:zippy/src/theme/text_input_decoration.dart';

class DropdownField extends StatefulWidget {
  final DropdownModel field;
  final ZippyFormBloc bloc;
  final Function(List<DropdownOption>)? onChanged;
  const DropdownField({
    super.key,
    required this.field,
    required this.bloc,
    required this.onChanged,
  });

  @override
  State<DropdownField> createState() => _DropdownFieldState();
}

class _DropdownFieldState extends State<DropdownField> {
  @override
  Widget build(BuildContext context) {
    return MultiDropdown(
      singleSelect: widget.field.validations.maxSelection == 1,
      maxSelections: widget.field.validations.maxSelection,
      fieldDecoration: getDropdownFieldDecoration(widget.field, widget.bloc),
      onSelectionChange: (selectedItems) {
        widget.bloc.dropdownValues[widget.field.fieldId] = selectedItems
            .map(
              (e) => e.value,
            )
            .toList();
        if (widget.onChanged != null) {
          widget.onChanged!(selectedItems);
        }
      },
      items: List.generate(
        widget.field.options.length,
        (index) => DropdownItem(
          label: widget.field.options[index].label,
          value: widget.field.options[index],
        ),
      ),
    );
  }
}
