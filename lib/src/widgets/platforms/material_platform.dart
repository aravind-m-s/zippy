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
import 'package:zippy/src/widgets/button/normal_buttons.dart';
import 'package:zippy/src/widgets/button/bottom_button.dart';
import 'package:zippy/src/widgets/button/top_buttons.dart';
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
import 'package:zippy/src/widgets/steps/steps_widget.dart';
import 'package:zippy/src/zippy.dart';

class MaterialPlatform extends StatelessWidget {
  const MaterialPlatform(
      {super.key,
      required this.widget,
      required this.bloc,
      required this.listener});

  final ZippyForm widget;
  final ZippyFormBloc bloc;
  final Function(BuildContext, ZippyFormState) listener;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<ZippyFormBloc, ZippyFormState>(
        listener: listener,
        builder: (context, state) {
          if (state is GetAllFieldsErrorState) {
            return Center(
              child: Text(state.message),
            );
          }

          if (state is GetAllFieldsLoadingState || state is ZippyFormInitial) {
            return widget.loadingWidget;
          }
          final currentStepIndex = bloc.steps.indexWhere(
            (element) => element.isCurrentStep == true,
          );

          return Column(
            children: [
              if (widget.buttonPosition == ButtonPosition.top)
                TopButtons.material(bloc: bloc, widget: widget)
              else
                const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: [
                    if (bloc.steps.isNotEmpty)
                      StepsWidget(
                          bloc: bloc,
                          widget: widget,
                          currentStepIndex: currentStepIndex),
                    ...List.generate(
                      bloc.fields[bloc.currentStep.id]!.length,
                      (index) {
                        final field = bloc.fields[bloc.currentStep.id]![index];
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: 16,
                              left: widget.horizontalPadding,
                              right: widget.horizontalPadding),
                          child: Wrap(
                            // crossAxis   Alignment: CrossAxisAlignment.start,
                            children: [
                              if (field is! HeadingModel &&
                                  field is! ParagraphModel &&
                                  field is! HiddenModel)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: LabelWidget(
                                    label: field.label,
                                    isRequired: field.validations.required,
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
                                TextFieldWidget.material(
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
                                  onChanged: widget.onAdvancedDropdownChange,
                                )
                              else if (field is UploadModel)
                                UploadField(
                                  field: field,
                                  bloc: bloc,
                                ),
                              if (bloc.errors[field.fieldId] != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
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
                    if (widget.buttonPosition == ButtonPosition.normal)
                      NormalButtons(widget: widget, bloc: bloc)
                  ],
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: widget.buttonPosition == ButtonPosition.bottom
          ? BottomButtons(
              bloc: bloc,
              backButtonText: widget.backButtonText,
              previousButtonText: widget.previousButtonText,
              nextButtonText: widget.nextButtonText,
              submitButtonText: widget.submitButtonText,
              hiddenFields: widget.hiddenFields,
            )
          : null,
    );
  }
}
