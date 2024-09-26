library zippy;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zippy/src/controllers/bloc/zippyform_bloc.dart';
import 'package:zippy/src/enums/enums.dart';
import 'package:zippy/src/models/advanced_dropdown.dart';
import 'package:zippy/src/models/dropdown.dart';
import 'package:zippy/src/widgets/button/top_next_button.dart';
import 'package:zippy/src/widgets/button/top_previous_button.dart';
import 'package:zippy/src/widgets/others/loading_widget.dart';
import 'package:zippy/src/widgets/platforms/cupertino_platform.dart';
import 'package:zippy/src/widgets/platforms/material_platform.dart';

export 'enums/enums.dart';

/// The `ZippyForm` widget renders a multi-step form with various field types and navigation.
/// It allows users to submit data step-by-step, handling errors, loading states, and more.
class ZippyForm extends StatefulWidget {
  /// Unique form identifier (required).
  final String formId;

  /// Identifier for form submission. Default is an empty string.
  final String submissionId;

  /// Map of hidden fields that should be submitted with the form data.
  final Map<String, String> hiddenFields;

  /// Text for the "Next" button. Default is "Next".
  final String nextButtonText;

  /// Text for the "Previous" button. Default is "Previous".
  final String previousButtonText;

  /// Text for the "Submit" button. Default is "Submit".
  final String submitButtonText;

  /// Text for the "Back" button, which takes users back to the previous screen. Default is "Back".
  final String backButtonText;

  /// Style of the platform (Material or Cupertino). Default is Material.
  final PlatformStyle platformStyle;

  /// Position of the form navigation buttons (Top, Bottom, Normal).
  final ButtonPosition buttonPosition;

  /// Mode for dropdown fields (Normal or Multi-select). Default is Normal.
  final DropdownMode dropdownMode;

  /// Enable or disable debug mode. Default is false.
  final bool debugMode;

  /// Horizontal padding for the form content. Default is 24.
  final double horizontalPadding;

  /// Function to handle errors. Provides an error message and the current context.
  final Function(String message, BuildContext context) errorWidget;

  /// Callback when the form is successfully submitted.
  final Function(BuildContext context) onSubmitted;

  /// Optional callback triggered when dropdown values change.
  final Function(List<DropdownOption> selectedItems)? onDropdownChange;

  /// Optional callback triggered when advanced dropdown values change.
  final Function(List<AdvancedDropdownItemModel> selectedItems)?
      onAdvancedDropdownChange;

  /// Widget to display during loading states. Default is a custom `LoadingWidget`.
  final Widget loadingWidget;

  /// The ZippyForm package provides a customizable form builder UI with step navigation, error handling,
  /// loading states, dropdowns, and various form field types.
  const ZippyForm({
    super.key,
    required this.formId,
    required this.errorWidget,
    required this.onSubmitted,
    this.submissionId = "",
    this.hiddenFields = const {},
    this.previousButtonText = "Previous",
    this.backButtonText = "Back",
    this.nextButtonText = "Next",
    this.submitButtonText = "Submit",
    this.platformStyle = PlatformStyle.material,
    this.buttonPosition = ButtonPosition.normal,
    this.dropdownMode = DropdownMode.normal,
    this.debugMode = false,
    this.onDropdownChange,
    this.onAdvancedDropdownChange,
    this.horizontalPadding = 24,
    this.loadingWidget = const LoadingWidget(),
  });

  @override
  State<ZippyForm> createState() => _ZippyFormState();
}

class _ZippyFormState extends State<ZippyForm> {
  late ZippyFormBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ZippyFormBloc()
        ..add(GetAllFieldsEvent(formId: widget.formId))
        ..debugMode = widget.debugMode,
      child: BlocBuilder<ZippyFormBloc, ZippyFormState>(
        builder: (context, state) {
          bloc = context.read<ZippyFormBloc>();
          return widget.platformStyle == PlatformStyle.material
              ? MaterialPlatform(
                  widget: widget,
                  bloc: bloc,
                  listener: listener,
                )
              : CupertinoPlatform(
                  widget: widget,
                  bloc: bloc,
                  listener: listener,
                );
        },
      ),
    );
  }

  listener(context, state) {
    if (state is GetAdvancedDropdownFieldsErrorState) {
      widget.errorWidget(state.message, context);
    } else if (state is SubmitDataForStepErrorState &&
        state.message != "validation_error") {
      widget.errorWidget(state.message, context);
    } else if (state is SubmitDataForStepSuccessState && state.isCompleted) {
      widget.onSubmitted(context);
      bloc.add(ClearItemsEvent());
    }
  }
}
