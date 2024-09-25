part of 'zippyform_bloc.dart';

sealed class ZippyFormEvent extends Equatable {
  const ZippyFormEvent();

  @override
  List<Object> get props => [];
}

final class GetAllFieldsEvent extends ZippyFormEvent {
  final String formId;
  final String submissionId;

  const GetAllFieldsEvent({required this.formId, this.submissionId = ""});
}

final class GetAdvancedDropdownFields extends ZippyFormEvent {
  final String fieldId;
  final String apiUrl;

  const GetAdvancedDropdownFields(
      {required this.fieldId, required this.apiUrl});
}

final class SubmitDataForStepEvent extends ZippyFormEvent {
  final String stepId;
  final Map<String, String> hiddenFields;

  const SubmitDataForStepEvent(
      {required this.stepId, required this.hiddenFields});
}

final class ClearItemsEvent extends ZippyFormEvent {}

final class UpdateUiEvent extends ZippyFormEvent {}
