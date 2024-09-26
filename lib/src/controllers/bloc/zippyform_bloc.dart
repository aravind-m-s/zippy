import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:zippy/src/api/api_provider.dart';
import 'package:zippy/src/core/validations.dart';
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
import 'package:zippy/src/models/step.dart';
import 'package:zippy/src/models/text_area.dart';
import 'package:zippy/src/models/textfield.dart';
import 'package:zippy/src/models/time.dart';
import 'package:zippy/src/models/upload.dart';
import 'package:zippy/src/models/website.dart';

part 'zippyform_event.dart';
part 'zippyform_state.dart';

class ZippyFormBloc extends Bloc<ZippyFormEvent, ZippyFormState> {
  bool debugMode = false;

  Map<String, List> fields = {};

  Map<String, TextEditingController> controllers = {};
  Map<String, List<String>> dropdownValues = {};
  Map<String, List<Map<String, dynamic>>> advancedValues = {};
  Map<String, List<String>> checkboxValues = {};
  Map<String, String> radioValues = {};
  Map<String, DateTime?> dateTimeValues = {};
  Map<String, String> uploadValues = {};

  final Map<String, String> errors = {};

  final List<StepModel> steps = [];

  StepModel currentStep = StepModel();

  String formId = "";
  String submissionId = "";

  final Map<String, List<DropdownItem<AdvancedDropdownItemModel>>>
      advancedDropdownItems = {};

  ZippyFormBloc() : super(ZippyFormInitial()) {
    on<GetAllFieldsEvent>(getAllFieldsBloc);
    on<GetAdvancedDropdownFields>(getAdvancedDropdownFields);
    on<SubmitDataForStepEvent>(submitDataForStepBloc);
    on<ClearItemsEvent>(clearItemsBloc);
    on<UpdateUiEvent>(
      (event, emit) => emit(
        UpdateUiState(
          dateTime: DateTime.now(),
        ),
      ),
    );
  }

  getAllFieldsBloc(
    GetAllFieldsEvent event,
    Emitter<ZippyFormState> emit,
  ) async {
    try {
      formId = event.formId;
      emit(GetAllFieldsLoadingState());
      final response = await ApiProvider.getAllFields(
          event.formId, currentStep.id, debugMode);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];

        if (data['form']['type'] == "payment_form") {
          emit(
            const GetAllFieldsErrorState(
              message: "Payment forms are not currently supported",
            ),
          );
          return;
        }

        if (data['steps'] != null) {
          steps.clear();
          for (var element in (data['steps'] as List)) {
            final step = StepModel.fromJson(element);
            steps.add(step);
            if (fields[step.id] == null) {
              fields[step.id] = [];
            }
            if (step.isCurrentStep) {
              currentStep = step;
            }
          }
        }

        if (data['fields'] != null &&
            fields[currentStep.id] != null &&
            fields[currentStep.id]!.isEmpty) {
          for (var element in (data['fields'] as List)) {
            switch (element['field_type']) {
              case "heading":
                fields[currentStep.id]!.add(HeadingModel.fromJson(element));
              case "paragraph":
                fields[currentStep.id]!.add(ParagraphModel.fromJson(element));
              case "text_box":
                fields[currentStep.id]!.add(TextFieldModel.fromJson(element));
                controllers[fields[currentStep.id]!.last.fieldId] =
                    TextEditingController();
              case "number":
                fields[currentStep.id]!.add(NumberFieldModel.fromJson(element));
                controllers[fields[currentStep.id]!.last.fieldId] =
                    TextEditingController();
              case "short_text_area" || "text_area":
                fields[currentStep.id]!.add(TextAreaModel.fromJson(element));
                controllers[fields[currentStep.id]!.last.fieldId] =
                    TextEditingController();
              case "website_url":
                fields[currentStep.id]!.add(WebsiteModel.fromJson(element));
                controllers[fields[currentStep.id]!.last.fieldId] =
                    TextEditingController();
              case "email":
                fields[currentStep.id]!.add(EmailModel.fromJson(element));
                controllers[fields[currentStep.id]!.last.fieldId] =
                    TextEditingController();
              case "phone_number":
                fields[currentStep.id]!.add(PhoneModel.fromJson(element));
                controllers[fields[currentStep.id]!.last.fieldId] =
                    TextEditingController();
              case "date":
                fields[currentStep.id]!.add(DateModel.fromJson(element));
                dateTimeValues[fields[currentStep.id]!.last.fieldId] = null;

              case "time":
                fields[currentStep.id]!.add(TimeModel.fromJson(element));
                dateTimeValues[fields[currentStep.id]!.last.fieldId] = null;

              case "radio":
                fields[currentStep.id]!.add(RadioModel.fromJson(element));
                radioValues[fields[currentStep.id]!.last.fieldId] = '';
              case "multiselect_checkbox":
                fields[currentStep.id]!.add(CheckboxModel.fromJson(element));
                checkboxValues[fields[currentStep.id]!.last.fieldId] = [];

              case "dropdown":
                fields[currentStep.id]!.add(DropdownModel.fromJson(element));
                dropdownValues[fields[currentStep.id]!.last.fieldId] = [];
              case "dynamic_dropdown":
                fields[currentStep.id]!
                    .add(AdvancedDropdownModel.fromJson(element));
                dropdownValues[fields[currentStep.id]!.last.fieldId] = [];
              case "file":
                fields[currentStep.id]!.add(UploadModel.fromJson(element));
                uploadValues[fields[currentStep.id]!.last.fieldId] = '';

              case "hidden":
                fields[currentStep.id]!.add(HiddenModel.fromJson(element));
              default:
                continue;
            }
          }
        }
        emit(GetAllFieldsSuccessState());
      } else {
        final body = jsonDecode(response.body);

        emit(
          GetAllFieldsErrorState(
            message: body['message'] ??
                body['msg'] ??
                body['error'] ??
                "Something went wrong, Please try again later",
          ),
        );
      }
    } catch (e, s) {
      if (debugMode) {
        log("-------------- Get All Fields Catch Bloc --------------",
            error: e, stackTrace: s);
      }
      emit(const GetAllFieldsErrorState(message: "Internal Error Occured"));
    }
  }

  getAdvancedDropdownFields(
    GetAdvancedDropdownFields event,
    Emitter<ZippyFormState> emit,
  ) async {
    try {
      emit(GetAdvancedDropdownFieldsLoadingState());
      if (advancedDropdownItems[event.fieldId] != null &&
          advancedDropdownItems[event.fieldId]!.isNotEmpty) {
        emit(
          GetAdvancedDropdownFieldsSuccessState(
            options: advancedDropdownItems[event.fieldId]!,
          ),
        );
        return;
      }
      final response =
          await ApiProvider.getAdvancedDropdownFields(event.apiUrl);

      if (response.statusCode == 200) {
        final List<DropdownItem<AdvancedDropdownItemModel>> options = [];

        final body = jsonDecode(response.body);
        if (body != []) {
          body.forEach((element) {
            final option = AdvancedDropdownItemModel.fromJson(element);
            options.add(DropdownItem(label: option.label, value: option));
          });
        }

        advancedDropdownItems[event.fieldId] = options;
        emit(GetAdvancedDropdownFieldsSuccessState(options: options));
      } else {
        emit(
          const GetAdvancedDropdownFieldsErrorState(
            message: "Unable to retrive the dropdown fields",
          ),
        );
      }
    } catch (e) {
      emit(const GetAdvancedDropdownFieldsErrorState(
          message: "Internal Error Occured"));
    }
  }

  submitDataForStepBloc(
    SubmitDataForStepEvent event,
    Emitter<ZippyFormState> emit,
  ) async {
    try {
      emit(SubmitDataForStepLoadingState());
      if (fields[event.stepId] == null) {
        emit(const SubmitDataForStepErrorState(message: "Invalid Step Id"));
        return;
      }

      for (var element in fields[event.stepId]!) {
        switch (element) {
          case TextFieldModel _:
            final error = FieldValidations.validateTextField(
                fieldName: element.label,
                value: controllers[element.fieldId]!.text,
                validations: element.validations);
            if (error != null) {
              errors[element.fieldId] = error;
            } else {
              if (errors.containsKey(element.fieldId)) {
                errors.remove(element.fieldId);
              }
            }
          case TextAreaModel _:
            final error = FieldValidations.validateTextArea(
                fieldName: element.label,
                value: controllers[element.fieldId]!.text,
                validations: element.validations);
            if (error != null) {
              errors[element.fieldId] = error;
            } else {
              if (errors.containsKey(element.fieldId)) {
                errors.remove(element.fieldId);
              }
            }
          case NumberFieldModel _:
            final error = FieldValidations.validateNumberField(
                fieldName: element.label,
                value: controllers[element.fieldId]!.text,
                validations: element.validations);
            if (error != null) {
              errors[element.fieldId] = error;
            } else {
              if (errors.containsKey(element.fieldId)) {
                errors.remove(element.fieldId);
              }
            }
          case WebsiteModel _:
            final error = FieldValidations.validateWebsiteField(
                fieldName: element.label,
                value: controllers[element.fieldId]!.text,
                validations: element.validations);
            if (error != null) {
              errors[element.fieldId] = error;
            } else {
              if (errors.containsKey(element.fieldId)) {
                errors.remove(element.fieldId);
              }
            }
          case EmailModel _:
            final error = FieldValidations.validateEmailField(
                fieldName: element.label,
                value: controllers[element.fieldId]!.text,
                validations: element.validations);
            if (error != null) {
              errors[element.fieldId] = error;
            } else {
              if (errors.containsKey(element.fieldId)) {
                errors.remove(element.fieldId);
              }
            }
          case PhoneModel _:
            final error = FieldValidations.validatePhoneField(
              fieldName: element.label,
              value: controllers[element.fieldId]!.text,
              validations: element.validations,
            );
            if (error != null) {
              errors[element.fieldId] = error;
            } else {
              if (errors.containsKey(element.fieldId)) {
                errors.remove(element.fieldId);
              }
            }
          case DateModel _:
            final error = FieldValidations.validateDateField(
              fieldName: element.label,
              value: (dateTimeValues[element.fieldId] ?? "").toString(),
              validations: element.validations,
            );
            if (error != null) {
              errors[element.fieldId] = error;
            } else {
              if (errors.containsKey(element.fieldId)) {
                errors.remove(element.fieldId);
              }
            }
          case TimeModel _:
            final error = FieldValidations.validateTimeField(
              fieldName: element.label,
              value: (dateTimeValues[element.fieldId] ?? "").toString(),
              validations: element.validations,
            );
            if (error != null) {
              errors[element.fieldId] = error;
            } else {
              if (errors.containsKey(element.fieldId)) {
                errors.remove(element.fieldId);
              }
            }
          case RadioModel _:
            final error = FieldValidations.validateRadioField(
              fieldName: element.label,
              value: radioValues[element.fieldId]!,
              validations: element.validations,
            );
            if (error != null) {
              errors[element.fieldId] = error;
            } else {
              if (errors.containsKey(element.fieldId)) {
                errors.remove(element.fieldId);
              }
            }
          case CheckboxModel _:
            final error = FieldValidations.validateCheckboxField(
              fieldName: element.label,
              values: checkboxValues[element.fieldId] ?? [],
              validations: element.validations,
            );
            if (error != null) {
              errors[element.fieldId] = error;
            } else {
              if (errors.containsKey(element.fieldId)) {
                errors.remove(element.fieldId);
              }
            }
          case DropdownModel _:
            final error = FieldValidations.validateDropdownField(
              fieldName: element.label,
              values: dropdownValues[element.fieldId] ?? [],
              validations: element.validations,
            );
            if (error != null) {
              errors[element.fieldId] = error;
            } else {
              if (errors.containsKey(element.fieldId)) {
                errors.remove(element.fieldId);
              }
            }
          case AdvancedDropdownModel _:
            final error = FieldValidations.validateAdvancedDropdownField(
              fieldName: element.label,
              values: advancedValues[element.fieldId] ?? [],
              validations: element.validations,
            );
            if (error != null) {
              errors[element.fieldId] = error;
            } else {
              if (errors.containsKey(element.fieldId)) {
                errors.remove(element.fieldId);
              }
            }
          case UploadModel _:
            final error = FieldValidations.validateUploadField(
              fieldName: element.label,
              value: uploadValues[element.fieldId] ?? "",
              validations: element.validations,
              lenght: File(uploadValues[element.fieldId] ?? "").lengthSync() /
                  (1024 * 1024),
            );
            if (error != null) {
              errors[element.fieldId] = error;
            } else {
              if (errors.containsKey(element.fieldId)) {
                errors.remove(element.fieldId);
              }
            }
        }
      }

      if (errors.isNotEmpty) {
        emit(const SubmitDataForStepErrorState(message: "validation_error"));
        return;
      }

      Map<String, String> apiFields = {};
      List<MultipartFile> apiFiles = [];

      for (var element in fields[event.stepId]!) {
        if (controllers[element.fieldId] != null) {
          apiFields[element.fieldId] =
              controllers[element.fieldId]!.text.trim();
        } else if (dropdownValues[element.fieldId] != null) {
          apiFields[element.fieldId] =
              jsonEncode(dropdownValues[element.fieldId]);
        } else if (advancedValues[element.fieldId] != null) {
          apiFields[element.fieldId] =
              jsonEncode(advancedValues[element.fieldId]);
        } else if (checkboxValues[element.fieldId] != null) {
          apiFields[element.fieldId] =
              jsonEncode(checkboxValues[element.fieldId]);
        } else if (radioValues[element.fieldId] != null) {
          apiFields[element.fieldId] = jsonEncode(radioValues[element.fieldId]);
        } else if (event.hiddenFields[element.fieldId] != null) {
          apiFields[element.fieldId] =
              jsonEncode(event.hiddenFields[element.fieldId]);
        } else if (dateTimeValues.containsKey(element.fieldId)) {
          if (element.fieldType == "date") {
            if (dateTimeValues[element.fieldId] == null) {
              apiFields[element.fieldId] = "";
            } else {
              apiFields[element.fieldId] = DateFormat(
                      element.validations.dateFormat == "d-m-y"
                          ? "dd-MM-yyyy"
                          : "MM-dd-yyyy")
                  .format(dateTimeValues[element.fieldId]!);
            }
          } else {
            if (dateTimeValues[element.fieldId] == null) {
              apiFields[element.fieldId] = "";
            } else {
              apiFields[element.fieldId] = DateFormat(
                      element.validations.timeFormat == "24"
                          ? "HH:mm"
                          : "hh:mm a")
                  .format(dateTimeValues[element.fieldId]!);
            }
          }
        } else if (uploadValues[element.fieldId] != null) {
          if (!uploadValues[element.fieldId]!.startsWith("http")) {
            final file = await MultipartFile.fromPath(
                element.fieldId, uploadValues[element.fieldId]!);

            apiFiles.add(file);
          }
        }
      }

      final response = await ApiProvider.submitDataForStep(
          formId, event.stepId, submissionId, apiFields, apiFiles);

      if (response.statusCode == 200) {
        submissionId = jsonDecode(response.body)['data']['submission_id'] ?? "";
        final index = steps.indexWhere(
          (element) => element.isCurrentStep,
        );
        final bool hasNextStep = index != -1 && index < steps.length - 1;
        emit(SubmitDataForStepSuccessState(isCompleted: !hasNextStep));

        if (index != -1 && index < steps.length - 1) {
          currentStep = steps[index + 1];
          add(GetAllFieldsEvent(formId: formId));
        }
      } else if (response.statusCode == 500) {
        emit(
          const SubmitDataForStepErrorState(
            message: "Internal Server Error",
          ),
        );
      } else {
        final body = jsonDecode(response.body);
        if (body['status'] == "validation_error" && body['data'] != null) {
          body['data'].forEach((key, value) {
            errors[key.toString()] = value.toString();
          });
          emit(const SubmitDataForStepErrorState(message: "validation_error"));
        } else {
          emit(SubmitDataForStepErrorState(
            message: body['message'] ??
                body['msg'] ??
                body['error'] ??
                "Somthing went wrong, please try again later",
          ));
        }
      }
    } catch (e) {
      emit(
          const SubmitDataForStepErrorState(message: "Internal Error Occured"));
    }
  }

  clearItemsBloc(
    ClearItemsEvent event,
    Emitter<ZippyFormState> emit,
  ) async {
    fields = {};

    controllers = {};
    dropdownValues = {};
    advancedValues = {};
    checkboxValues = {};
    radioValues = {};
    dateTimeValues = {};
    uploadValues = {};

    errors.clear();

    steps.clear();

    currentStep = StepModel();

    submissionId = "";

    add(GetAllFieldsEvent(formId: formId));
  }
}
