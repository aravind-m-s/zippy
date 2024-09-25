import 'package:flutter/material.dart';
import 'package:zippy/src/controllers/bloc/zippyform_bloc.dart';
import 'package:zippy/src/core/app_colors.dart';

class BottomPreviousAndBackButton extends StatelessWidget {
  final String label;
  final ZippyFormBloc bloc;
  const BottomPreviousAndBackButton(
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
      child: Expanded(
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width / 2,
          decoration: const BoxDecoration(
            color: AppColors.zippyPreviousColor,
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
      ),
    );
  }
}
