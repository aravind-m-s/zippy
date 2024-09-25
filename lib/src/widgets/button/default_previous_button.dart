import 'package:flutter/material.dart';
import 'package:zippy/src/controllers/bloc/zippyform_bloc.dart';
import 'package:zippy/src/core/app_colors.dart';

class PreviousAndBackButton extends StatelessWidget {
  final String label;
  final ZippyFormBloc bloc;
  const PreviousAndBackButton(
      {super.key, required this.bloc, required this.label});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final index = bloc.steps.indexWhere((element) => element.isCurrentStep);
        if (index != 0) {
          bloc.steps[index].isCurrentStep = false;
          bloc.steps[index - 1].isCurrentStep = true;
          bloc.currentStep = bloc.steps[index - 1];
          bloc.add(UpdateUiEvent());
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 24,
        ),
        decoration: BoxDecoration(
          color: AppColors.zippyPreviousColor,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
