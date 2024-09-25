
# Zippy Form Package

Zippy Form is a dynamic, customizable form solution built with Flutter. It provides flexibility to create multi-step forms with various field types, navigation buttons, validation, and customization options for a seamless user experience across different platforms.

## Features

- Multi-step form navigation
- Extensive form field support, including:
  - Text fields
  - Number fields
  - Dropdowns
  - Email, phone, and website inputs
  - Radio buttons, checkboxes, and file uploads
  - Date and time pickers
- Customizable buttons and form appearance
- Error handling and validation support
- Advanced dropdowns with customizable options

## Installation

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  zippy:
    git:
      url: https://github.com/your-repo/zippy.git
```

Then, run `flutter pub get` to install the package.

## Usage

To use the `ZippyForm` widget in your Flutter application, follow these steps:

### 1. Import the necessary files

```dart
import 'package:zippy/zippy.dart';
```

### 2. Use the `ZippyForm` widget

```dart
ZippyForm(
  formId: 'your-form-id',
  onSubmitted: (context) {
    // Handle form submission
  },
  errorWidget: (message, context) {
    // Handle error display
  },
)
```

### 3. Customize the form

You can customize various aspects of the form, such as button text, debug mode, platform styles, and more. Below is an example with additional customization:

```dart
ZippyForm(
  formId: 'your-form-id',
  submissionId: 'submission-id',
  hiddenFields: {'field1': 'value1', 'field2': 'value2'},
  nextButtonText: 'Continue',
  previousButtonText: 'Go Back',
  submitButtonText: 'Finish',
  platformStyle: PlatformStyle.cupertino,
  buttonPosition: ButtonPosition.bottom,
  dropdownMode: DropdownMode.searchable,
  debugMode: true,
  onDropdownChange: (selectedItems) {
    // Handle dropdown change
  },
  onAdvancedDropdownChange: (selectedItems) {
    // Handle advanced dropdown change
  },
  onSubmitted: (context) {
    // Handle form submission
  },
  errorWidget: (message, context) {
    // Handle errors
  },
)
```

## ZippyForm Parameters

| Parameter                | Type                                                   | Description                                                                                             |
|--------------------------|--------------------------------------------------------|---------------------------------------------------------------------------------------------------------|
| `formId`                 | `String`                                               | The unique identifier for the form.                                                                     |
| `submissionId`           | `String`                                               | The unique identifier for a submission. Default is an empty string.                                      |
| `hiddenFields`           | `Map<String, String>`                                  | Map of hidden fields that are sent with each form submission.                                            |
| `nextButtonText`         | `String`                                               | Text to display on the "Next" button. Default is "Next".                                                 |
| `previousButtonText`     | `String`                                               | Text to display on the "Previous" button. Default is "Previous".                                         |
| `submitButtonText`       | `String`                                               | Text to display on the "Submit" button. Default is "Submit".                                             |
| `backButtonText`         | `String`                                               | Text to display on the "Back" button. Default is "Back".                                                 |
| `platformStyle`          | `PlatformStyle`                                        | Platform-specific style for the form. Supports `PlatformStyle.material` and `PlatformStyle.cupertino`.   |
| `buttonPosition`         | `ButtonPosition`                                       | Position of the buttons. Options are `ButtonPosition.normal`, `ButtonPosition.top`, and `ButtonPosition.bottom`. |
| `dropdownMode`           | `DropdownMode`                                         | Mode for dropdown fields. Options are `DropdownMode.normal` and `DropdownMode.searchable`.               |
| `debugMode`              | `bool`                                                 | Enables or disables debug mode. Default is `false`.                                                      |
| `horizontalPadding`      | `double`                                               | Horizontal padding for the form layout. Default is `24`.                                                 |
| `errorWidget`            | `Function(String message, BuildContext context)`       | Function to handle error display when form submission fails.                                             |
| `onSubmitted`            | `Function(BuildContext context)`                       | Callback function to handle actions when the form is successfully submitted.                             |
| `onDropdownChange`       | `Function(List<DropdownOption> selectedItems)?`        | Callback function for handling changes in dropdown selection. Optional.                                  |
| `onAdvancedDropdownChange`| `Function(List<AdvancedDropdownItemModel> selectedItems)?`| Callback function for handling changes in advanced dropdown selection. Optional.                        |
| `loadingWidget`          | `Widget`                                               | Custom widget to display while the form is loading. Default is `LoadingWidget()`.                        |

## Example

Here is a full example of a ZippyForm with multiple fields and customization:

```dart
import 'package:flutter/material.dart';
import 'package:zippy/zippy.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Zippy Form Example'),
        ),
        body: ZippyForm(
          formId: '12345',
          onSubmitted: (context) {
            // Form submission logic
          },
          errorWidget: (message, context) {
            // Error handling logic
          },
          nextButtonText: 'Next Step',
          submitButtonText: 'Submit Form',
          buttonPosition: ButtonPosition.bottom,
          platformStyle: PlatformStyle.material,
        ),
      ),
    );
  }
}
```

## Contributions

Feel free to contribute by submitting a pull request, opening an issue, or giving feedback!

## License

This package is licensed under the MIT License.