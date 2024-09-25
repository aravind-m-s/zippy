part of 'zippyform_bloc.dart';

sealed class ZippyFormState extends Equatable {
  const ZippyFormState();

  @override
  List<Object> get props => [];
}

final class ZippyFormInitial extends ZippyFormState {}

final class GetAllFieldsLoadingState extends ZippyFormState {}

final class GetAllFieldsSuccessState extends ZippyFormState {
  @override
  List<Object> get props => [];
}

final class GetAllFieldsErrorState extends ZippyFormState {
  final String message;

  const GetAllFieldsErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

final class GetAdvancedDropdownFieldsLoadingState extends ZippyFormState {}

final class GetAdvancedDropdownFieldsSuccessState extends ZippyFormState {
  final List<DropdownItem<AdvancedDropdownItemModel>> options;

  const GetAdvancedDropdownFieldsSuccessState({required this.options});
  @override
  List<Object> get props => [options];
}

final class GetAdvancedDropdownFieldsErrorState extends ZippyFormState {
  final String message;

  const GetAdvancedDropdownFieldsErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

final class SubmitDataForStepLoadingState extends ZippyFormState {}

final class SubmitDataForStepSuccessState extends ZippyFormState {
  final bool isCompleted;

  const SubmitDataForStepSuccessState({required this.isCompleted});
  @override
  List<Object> get props => [isCompleted];
}

final class SubmitDataForStepErrorState extends ZippyFormState {
  final String message;

  const SubmitDataForStepErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

final class UpdateUiState extends ZippyFormState {
  final DateTime dateTime;

  const UpdateUiState({required this.dateTime});

  @override
  List<Object> get props => [dateTime];
}
