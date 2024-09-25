import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:zippy/src/controllers/bloc/zippyform_bloc.dart';
import 'package:zippy/src/models/advanced_dropdown.dart';
import 'package:zippy/src/theme/text_input_decoration.dart';

class AdvancedDropdownField extends StatefulWidget {
  final AdvancedDropdownModel field;
  final ZippyFormBloc bloc;
  final Function(List<AdvancedDropdownItemModel>)? onChanged;
  final Function(String, BuildContext) errorWidget;

  const AdvancedDropdownField(
      {super.key,
      required this.field,
      required this.errorWidget,
      required this.bloc,
      this.onChanged});

  @override
  State<AdvancedDropdownField> createState() => _AdvancedDropdownFieldState();
}

class _AdvancedDropdownFieldState extends State<AdvancedDropdownField> {
  final List<DropdownItem<AdvancedDropdownItemModel>> options = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<ZippyFormBloc>().add(
          GetAdvancedDropdownFields(
            fieldId: widget.field.fieldId,
            apiUrl: widget.field.optionApiUrl,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ZippyFormBloc, ZippyFormState>(
      listener: (context, state) {
        if (state is GetAdvancedDropdownFieldsErrorState) {
          widget.errorWidget(state.message, context);
        } else if (state is GetAdvancedDropdownFieldsSuccessState) {
          options.addAll(state.options);
        }
      },
      builder: (context, state) {
        return MultiDropdown(
          items: options,
          onSelectionChange: (selectedItems) {
            widget.bloc.advancedValues[widget.field.fieldId] = selectedItems
                .map(
                  (e) => {e.id: e.label},
                )
                .toList();
            if (widget.onChanged != null) {
              widget.onChanged!(selectedItems);
            }
          },
          singleSelect: widget.field.validations.maxSelection == 1,
          maxSelections: widget.field.validations.maxSelection,
          fieldDecoration:
              getDropdownFieldDecoration(widget.field, widget.bloc),
        );
      },
    );
  }
}
