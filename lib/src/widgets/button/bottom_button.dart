import 'package:flutter/material.dart';
import 'package:zippy/src/controllers/bloc/zippyform_bloc.dart';
import 'package:zippy/src/widgets/button/bottom_next_button.dart';
import 'package:zippy/src/widgets/button/bottom_previous_button.dart';

class BottomButtons extends StatelessWidget {
  final ZippyFormBloc bloc;
  final String backButtonText;
  final String previousButtonText;
  final String nextButtonText;
  final String submitButtonText;
  final Map<String, String> hiddenFields;
  const BottomButtons(
      {super.key,
      required this.bloc,
      required this.backButtonText,
      required this.previousButtonText,
      required this.nextButtonText,
      required this.submitButtonText,
      required this.hiddenFields});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BottomPreviousAndBackButton(
          bloc: bloc,
          label: bloc.steps.indexOf(bloc.currentStep) == 0
              ? backButtonText
              : previousButtonText,
        ),
        BottomNextAndSubmitButton(
          bloc: bloc,
          label: bloc.steps.indexOf(bloc.currentStep) == bloc.steps.length - 1
              ? nextButtonText
              : submitButtonText,
          hiddenFields: hiddenFields,
        ),
      ],
    );
  }
}
