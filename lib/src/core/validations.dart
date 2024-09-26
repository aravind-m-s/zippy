import 'package:zippy/src/models/textfield.dart' as text_field;
import 'package:zippy/src/models/text_area.dart' as text_area;
import 'package:zippy/src/models/number_field.dart' as number_field;
import 'package:zippy/src/models/website.dart' as website_field;
import 'package:zippy/src/models/email.dart' as email_field;
import 'package:zippy/src/models/phone_number_field.dart' as phone_field;
import 'package:zippy/src/models/date.dart' as date_field;
import 'package:zippy/src/models/time.dart' as time_field;
import 'package:zippy/src/models/radio.dart' as radio_field;
import 'package:zippy/src/models/checkbox.dart' as checkbox_field;
import 'package:zippy/src/models/dropdown.dart' as dropdown_field;
import 'package:zippy/src/models/advanced_dropdown.dart'
    as advanced_dropdown_field;
import 'package:zippy/src/models/upload.dart' as upload_field;

class FieldValidations {
  static String? validateTextField({
    required String fieldName,
    required String value,
    required text_field.Validations validations,
  }) {
    String? error;
    if (validations.required && value.trim().isEmpty) {
      error = "$fieldName is Required";
    } else if (validations.minlength > value.trim().length) {
      error =
          "$fieldName should be atleast ${validations.minlength} characters";
    }

    return error;
  }

  static String? validateTextArea({
    required String fieldName,
    required String value,
    required text_area.Validations validations,
  }) {
    String? error;
    if (validations.required && value.trim().isEmpty) {
      error = "$fieldName is Required";
    } else if (validations.minlength > value.trim().length) {
      error =
          "$fieldName should be atleast ${validations.minlength} characters";
    }

    return error;
  }

  static String? validateNumberField({
    required String fieldName,
    required String value,
    required number_field.Validations validations,
  }) {
    String? error;

    if (validations.required && value.trim().isEmpty) {
      error = "$fieldName is Required";
    } else if (validations.min > (double.tryParse(value.trim()) ?? 0)) {
      error = "$fieldName should be atleast ${validations.min}";
    } else if (validations.max < (double.tryParse(value.trim()) ?? 0)) {
      error = "$fieldName should be less than ${validations.max}";
    } else if (value.split(".").length > 1 &&
        value.split(".").last.length > validations.decimalPlaces) {
      error =
          "$fieldName can only have ${validations.decimalPlaces} decimal places";
    }
    return error;
  }

  static String? validateWebsiteField({
    required String fieldName,
    required String value,
    required website_field.Validations validations,
  }) {
    String? error;
    if (validations.required && value.trim().isEmpty) {
      error = "$fieldName is Required";
    } else if (isValidURL(value.trim())) {
      error = "$fieldName is not valid";
    }
    return error;
  }

  static String? validateEmailField({
    required String fieldName,
    required String value,
    required email_field.Validations validations,
  }) {
    String? error;
    if (validations.required && value.trim().isEmpty) {
      error = "$fieldName is Required";
    } else if (isValidEmail(value.trim())) {
      error = "$fieldName is not valid";
    }
    return error;
  }

  static String? validatePhoneField({
    required String fieldName,
    required String value,
    required phone_field.Validations validations,
  }) {
    String? error;
    if (validations.required && value.trim().isEmpty) {
      error = "$fieldName is Required";
    } else if (validations.minlength > value.trim().length) {
      error =
          "$fieldName should be atleast ${validations.minlength} characters";
    }

    return error;
  }

  static String? validateDateField({
    required String fieldName,
    required String value,
    required date_field.Validations validations,
  }) {
    String? error;
    if (validations.required && value.trim().isEmpty) {
      error = "$fieldName is Required";
    }

    return error;
  }

  static String? validateTimeField({
    required String fieldName,
    required String value,
    required time_field.Validations validations,
  }) {
    String? error;
    if (validations.required && value.trim().isEmpty) {
      error = "$fieldName is Required";
    }

    return error;
  }

  static String? validateRadioField({
    required String fieldName,
    required String value,
    required radio_field.Validations validations,
  }) {
    String? error;
    if (validations.required && value.trim().isEmpty) {
      error = "$fieldName is Required";
    }

    return error;
  }

  static String? validateCheckboxField({
    required String fieldName,
    required List<String> values,
    required checkbox_field.Validations validations,
  }) {
    String? error;
    if (validations.required && values.isEmpty) {
      error = "$fieldName is Required";
    }

    return error;
  }

  static String? validateDropdownField({
    required String fieldName,
    required List<String> values,
    required dropdown_field.Validations validations,
  }) {
    String? error;
    if (validations.required && values.isEmpty) {
      error = "$fieldName is Required";
    }

    return error;
  }

  static String? validateAdvancedDropdownField({
    required String fieldName,
    required List<Map<String, dynamic>> values,
    required advanced_dropdown_field.Validations validations,
  }) {
    String? error;
    if (validations.required && values.isEmpty) {
      error = "$fieldName is Required";
    }

    return error;
  }

  static String? validateUploadField({
    required String fieldName,
    required String value,
    required double lenght,
    required upload_field.Validations validations,
  }) {
    String? error;
    if (validations.required && value.trim().isEmpty) {
      error = "$fieldName is Required";
    } else if (validations.fileMaxSizeMb < lenght) {
      error = "$fieldName should be less than ${validations.fileMaxSizeMb} MB";
    }
    return error;
  }

  static bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    return emailRegex.hasMatch(email);
  }

  static bool isValidURL(String url) {
    final urlPattern = RegExp(
        r'^(https?:\/\/(www\.)?|www\.)[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}([/?].*)?$');
    return urlPattern.hasMatch(url);
  }
}
