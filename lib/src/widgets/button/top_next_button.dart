import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:zippy/src/controllers/bloc/zippyform_bloc.dart';

class TopNextAndSubmitButton extends StatelessWidget {
  const TopNextAndSubmitButton({
    super.key,
    required this.bloc,
    required this.label,
    required this.hiddenFields,
  });

  final ZippyFormBloc bloc;
  final String label;
  final Map<String, String> hiddenFields;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        bloc.add(
          SubmitDataForStepEvent(
            stepId: bloc.currentStep.id,
            hiddenFields: hiddenFields,
          ),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          if (bloc.state is SubmitDataForStepLoadingState)
            const SizedBox(width: 8),
          if (bloc.state is SubmitDataForStepLoadingState)
            LoadingAnimationWidget.twoRotatingArc(
                color: Colors.black, size: 18),
          const SizedBox(width: 16),
        ],
      ),
    );
  }
}
