import 'package:flutter/material.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:zippy/src/controllers/bloc/zippyform_bloc.dart';
import 'package:zippy/src/core/app_colors.dart';

getInputDecoration(field, ZippyFormBloc bloc) => InputDecoration(
      suffixIcon: field.fieldFormat.inputGroupIcon.isNotEmpty &&
              field.fieldFormat.inputGroupIconPosition == "end"
          ? const SizedBox()
          : null,
      prefixIcon: field.fieldFormat.inputGroupIcon.isNotEmpty &&
              field.fieldFormat.inputGroupIconPosition == "start"
          ? const SizedBox()
          : null,
      counterText: '',
      enabledBorder: enabledBorder(bloc.errors[field.fieldId] != null),
      focusedBorder: focusedBorder(bloc.errors[field.fieldId] != null),
      hintText: field.placeholder,
      errorStyle: const TextStyle(
        fontSize: 14,
      ),
    );

InputDecoration getInputDecorationWithoutFieldFormat(
        field, ZippyFormBloc bloc) =>
    InputDecoration(
      counterText: '',
      enabledBorder: enabledBorder(bloc.errors[field.fieldId] != null),
      focusedBorder: focusedBorder(bloc.errors[field.fieldId] != null),
      hintText: field.placeholder,
      errorStyle: const TextStyle(
        fontSize: 14,
      ),
    );

FieldDecoration getDropdownFieldDecoration(field, ZippyFormBloc bloc) =>
    FieldDecoration(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      border: enabledBorder(bloc.errors[field.fieldId] != null),
      focusedBorder: focusedBorder(bloc.errors[field.fieldId] != null),
      hintText: field.placeholder,
    );

getAreaInputDecoration(field, ZippyFormBloc bloc) => InputDecoration(
      counterText: '',
      enabledBorder: enabledBorder(bloc.errors[field.fieldId] != null),
      focusedBorder: focusedBorder(bloc.errors[field.fieldId] != null),
      hintText: field.placeholder,
      errorStyle: const TextStyle(
        fontSize: 14,
      ),
    );

OutlineInputBorder focusedBorder(bool isError) {
  return OutlineInputBorder(
    borderSide: BorderSide(
      color: !isError ? AppColors.zippyPrimaryColor : AppColors.zippyErrorColor,
      width: 1,
    ),
    borderRadius: BorderRadius.circular(12),
  );
}

OutlineInputBorder enabledBorder(bool isError) {
  return OutlineInputBorder(
    borderSide: BorderSide(
      color: !isError ? AppColors.zippyBorderColor : AppColors.zippyErrorColor,
      width: 1,
    ),
    borderRadius: BorderRadius.circular(12),
  );
}
