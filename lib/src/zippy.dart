library zippy;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zippy/src/controllers/bloc/zippyform_bloc.dart';
import 'package:zippy/src/core/app_colors.dart';
import 'package:zippy/src/enums/enums.dart';
import 'package:zippy/src/models/advanced_dropdown.dart';
import 'package:zippy/src/models/checkbox.dart';
import 'package:zippy/src/models/date.dart';
import 'package:zippy/src/models/dropdown.dart';
import 'package:zippy/src/models/email.dart';
import 'package:zippy/src/models/heading.dart';
import 'package:zippy/src/models/hidden.dart';
import 'package:zippy/src/models/number_field.dart';
import 'package:zippy/src/models/paragraph.dart';
import 'package:zippy/src/models/phone_number_field.dart';
import 'package:zippy/src/models/radio.dart';
import 'package:zippy/src/models/text_area.dart';
import 'package:zippy/src/models/textfield.dart';
import 'package:zippy/src/models/time.dart';
import 'package:zippy/src/models/upload.dart';
import 'package:zippy/src/models/website.dart';
import 'package:zippy/src/widgets/button/default_next_button.dart';
import 'package:zippy/src/widgets/button/default_previous_button.dart';
import 'package:zippy/src/widgets/button/top_next_button.dart';
import 'package:zippy/src/widgets/button/top_previous_button.dart';
import 'package:zippy/src/widgets/button/bottom_next_button.dart';
import 'package:zippy/src/widgets/button/bottom_previous_button.dart';
import 'package:zippy/src/widgets/fields/advanced_dropdown.dart';
import 'package:zippy/src/widgets/fields/checkbox.dart';
import 'package:zippy/src/widgets/fields/date.dart';
import 'package:zippy/src/widgets/fields/dropdown.dart';
import 'package:zippy/src/widgets/fields/email.dart';
import 'package:zippy/src/widgets/fields/heading.dart';
import 'package:zippy/src/widgets/fields/number_field.dart';
import 'package:zippy/src/widgets/fields/paragraph.dart';
import 'package:zippy/src/widgets/fields/phone_number.dart';
import 'package:zippy/src/widgets/fields/radio.dart';
import 'package:zippy/src/widgets/fields/text_area.dart';
import 'package:zippy/src/widgets/fields/textfield.dart';
import 'package:zippy/src/widgets/fields/time.dart';
import 'package:zippy/src/widgets/fields/upload.dart';
import 'package:zippy/src/widgets/fields/website.dart';
import 'package:zippy/src/widgets/others/label_widget.dart';
import 'package:zippy/src/widgets/others/loading_widget.dart';

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

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: widget.buttonPosition == ButtonPosition.top
                ? AppBar(
                    scrolledUnderElevation: 0,
                    surfaceTintColor: Colors.transparent,
                    backgroundColor: Colors.white,
                    elevation: 0.5,
                    leadingWidth: 100,
                    shadowColor: Colors.grey,
                    leading: TopPreviousAndBackButton(
                      bloc: bloc,
                      label: bloc.steps.indexOf(bloc.currentStep) == 0
                          ? widget.backButtonText
                          : widget.previousButtonText,
                    ),
                    actions: [
                      TopNextAndSubmitButton(
                        bloc: bloc,
                        label: bloc.steps.indexOf(bloc.currentStep) ==
                                bloc.steps.length - 1
                            ? widget.submitButtonText
                            : widget.nextButtonText,
                        hiddenFields: widget.hiddenFields,
                      ),
                    ],
                  )
                : null,
            body: BlocConsumer<ZippyFormBloc, ZippyFormState>(
              listener: (context, state) {
                if (state is GetAdvancedDropdownFieldsErrorState) {
                  widget.errorWidget(state.message, context);
                } else if (state is SubmitDataForStepErrorState &&
                    state.message != "validation_error") {
                  widget.errorWidget(state.message, context);
                } else if (state is SubmitDataForStepSuccessState &&
                    state.isCompleted) {
                  widget.onSubmitted(context);
                  bloc.add(ClearItemsEvent());
                }
              },
              builder: (context, state) {
                if (state is GetAllFieldsErrorState) {
                  return Center(
                    child: Text(state.message),
                  );
                }

                if (state is GetAllFieldsLoadingState ||
                    state is ZippyFormInitial) {
                  return widget.loadingWidget;
                }
                final currentStepIndex = bloc.steps.indexWhere(
                  (element) => element.isCurrentStep == true,
                );

                return Column(
                  children: [
                    SizedBox(
                      height:
                          widget.buttonPosition == ButtonPosition.top ? 16 : 0,
                    ),
                    Expanded(
                      child: ListView(
                        children: [
                          if (bloc.steps.isNotEmpty)
                            LimitedBox(
                              maxHeight: 100,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: List.generate(
                                          bloc.steps.length,
                                          (index) => Padding(
                                            padding: EdgeInsets.only(
                                                left: index == 0
                                                    ? widget.horizontalPadding
                                                    : 0,
                                                right: index ==
                                                        bloc.steps.length - 1
                                                    ? widget.horizontalPadding
                                                    : 0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                if (index != 0)
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 8.0,
                                                    ),
                                                    child: Container(
                                                      height: 1,
                                                      width: 100,
                                                      color: currentStepIndex >=
                                                              index
                                                          ? AppColors
                                                              .zippyPrimaryColor
                                                          : AppColors
                                                              .zippyPrimaryColor
                                                              .withOpacity(
                                                                  0.15),
                                                    ),
                                                  ),
                                                CircleAvatar(
                                                  backgroundColor:
                                                      currentStepIndex >= index
                                                          ? AppColors
                                                              .zippyPrimaryColor
                                                          : AppColors
                                                              .zippyPrimaryColor
                                                              .withOpacity(
                                                                  0.15),
                                                  radius: 30,
                                                  child: Text(
                                                    (index + 1).toString(),
                                                    style: TextStyle(
                                                      fontSize: 24,
                                                      color: currentStepIndex >=
                                                              index
                                                          ? Colors.white
                                                          : AppColors
                                                              .zippyPrimaryColor,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 25,
                                        child: Row(
                                          children: List.generate(
                                            bloc.steps.length,
                                            (index) => Padding(
                                              padding: EdgeInsets.only(
                                                  left: index == 0
                                                      ? widget.horizontalPadding
                                                      : 0,
                                                  right: index ==
                                                          bloc.steps.length - 1
                                                      ? widget.horizontalPadding
                                                      : 0),
                                              child: SizedBox(
                                                width: 175,
                                                child: Text(
                                                  bloc.steps[index].name,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ...List.generate(
                            bloc.fields[bloc.currentStep.id]!.length,
                            (index) {
                              final field =
                                  bloc.fields[bloc.currentStep.id]![index];
                              return Padding(
                                padding: EdgeInsets.only(
                                    bottom: 16,
                                    left: widget.horizontalPadding,
                                    right: widget.horizontalPadding),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (field is! HeadingModel &&
                                        field is! ParagraphModel &&
                                        field is! HiddenModel)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 4),
                                        child: LabelWidget(
                                          label: field.label,
                                          isRequired:
                                              field.validations.required,
                                        ),
                                      ),
                                    if (field is HeadingModel)
                                      HeadingField(
                                        field: field,
                                      )
                                    else if (field is ParagraphModel)
                                      ParagraphField(
                                        field: field,
                                      )
                                    else if (field is TextFieldModel)
                                      TextFieldWidget(
                                        field: field,
                                        bloc: bloc,
                                      )
                                    else if (field is NumberFieldModel)
                                      NumberField(
                                        field: field,
                                        bloc: bloc,
                                      )
                                    else if (field is TextAreaModel)
                                      TextAreaField(
                                        field: field,
                                        bloc: bloc,
                                      )
                                    else if (field is WebsiteModel)
                                      WebsiteField(
                                        field: field,
                                        bloc: bloc,
                                      )
                                    else if (field is EmailModel)
                                      EmailField(
                                        field: field,
                                        bloc: bloc,
                                      )
                                    else if (field is PhoneModel)
                                      PhoneField(
                                        field: field,
                                        bloc: bloc,
                                      )
                                    else if (field is DateModel)
                                      DateField(
                                        field: field,
                                        bloc: bloc,
                                      )
                                    else if (field is TimeModel)
                                      TimeField(
                                        field: field,
                                        bloc: bloc,
                                      )
                                    else if (field is RadioModel)
                                      RadioField(
                                        field: field,
                                        bloc: bloc,
                                      )
                                    else if (field is CheckboxModel)
                                      CheckboxField(
                                        field: field,
                                        bloc: bloc,
                                      )
                                    else if (field is DropdownModel)
                                      DropdownField(
                                        field: field,
                                        bloc: bloc,
                                        onChanged: widget.onDropdownChange,
                                      )
                                    else if (field is AdvancedDropdownModel)
                                      AdvancedDropdownField(
                                        field: field,
                                        errorWidget: widget.errorWidget,
                                        bloc: bloc,
                                        onChanged:
                                            widget.onAdvancedDropdownChange,
                                      )
                                    else if (field is UploadModel)
                                      UploadField(
                                        field: field,
                                        bloc: bloc,
                                      ),
                                    if (bloc.errors[field.fieldId] != null)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 4.0),
                                        child: Text(
                                          bloc.errors[field.fieldId] ?? "",
                                          style: const TextStyle(
                                            color: AppColors.zippyErrorColor,
                                          ),
                                        ),
                                      )
                                  ],
                                ),
                              );
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: widget.horizontalPadding),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if (widget.buttonPosition ==
                                    ButtonPosition.normal)
                                  PreviousAndBackButton(
                                    bloc: bloc,
                                    label:
                                        bloc.steps.indexOf(bloc.currentStep) ==
                                                0
                                            ? widget.backButtonText
                                            : widget.previousButtonText,
                                  ),
                                if (widget.buttonPosition ==
                                    ButtonPosition.normal)
                                  NextAndSubmitButton(
                                    bloc: bloc,
                                    label:
                                        bloc.steps.indexOf(bloc.currentStep) ==
                                                bloc.steps.length - 1
                                            ? widget.submitButtonText
                                            : widget.nextButtonText,
                                    hiddenFields: widget.hiddenFields,
                                  ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            bottomNavigationBar: widget.buttonPosition == ButtonPosition.bottom
                ? Row(
                    children: [
                      BottomPreviousAndBackButton(
                        bloc: bloc,
                        label: bloc.steps.indexOf(bloc.currentStep) == 0
                            ? widget.backButtonText
                            : widget.previousButtonText,
                      ),
                      BottomNextAndSubmitButton(
                        bloc: bloc,
                        label: bloc.steps.indexOf(bloc.currentStep) ==
                                bloc.steps.length - 1
                            ? widget.nextButtonText
                            : widget.submitButtonText,
                        hiddenFields: widget.hiddenFields,
                      ),
                    ],
                  )
                : null,
          );
        },
      ),
    );
  }
}
