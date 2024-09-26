import 'package:flutter/material.dart';
import 'package:zippy/src/controllers/bloc/zippyform_bloc.dart';
import 'package:zippy/src/widgets/button/default_next_button.dart';
import 'package:zippy/src/widgets/button/default_previous_button.dart';
import 'package:zippy/src/zippy.dart';

class NormalButtons extends StatelessWidget {
  const NormalButtons({
    super.key,
    required this.widget,
    required this.bloc,
  });

  final ZippyForm widget;
  final ZippyFormBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: widget.horizontalPadding),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
        children: [
          PreviousAndBackButton(
            bloc: bloc,
            label:
                bloc.steps.indexOf(bloc.currentStep) ==
                        0
                    ? widget.backButtonText
                    : widget.previousButtonText,
          ),
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
    );
  }
}
