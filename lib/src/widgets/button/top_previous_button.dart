import 'package:flutter/material.dart';
import 'package:zippy/src/controllers/bloc/zippyform_bloc.dart';

class TopPreviousAndBackButton extends StatelessWidget {
  final String label;
  final ZippyFormBloc bloc;
  const TopPreviousAndBackButton(
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
      
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
