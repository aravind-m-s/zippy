import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:zippy/src/controllers/bloc/zippyform_bloc.dart';
import 'package:zippy/src/core/app_colors.dart';

class BottomNextAndSubmitButton extends StatelessWidget {
  const BottomNextAndSubmitButton({
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
      child: Expanded(
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width / 2,
          decoration: const BoxDecoration(
            color: AppColors.zippyPrimaryColor,
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              if (bloc.state is SubmitDataForStepLoadingState)
                const SizedBox(width: 8),
              if (bloc.state is SubmitDataForStepLoadingState)
                LoadingAnimationWidget.twoRotatingArc(
                    color: Colors.white, size: 18)
            ],
          ),
        ),
      ),
    );
  }
}
