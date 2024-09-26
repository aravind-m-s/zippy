import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zippy/src/controllers/bloc/zippyform_bloc.dart';

class TopPreviousAndBackButton extends StatelessWidget {
  final String label;
  final ZippyFormBloc bloc;
  final bool _isMaterial;
  const TopPreviousAndBackButton.material(
      {super.key, required this.bloc, required this.label})
      : _isMaterial = true;

  const TopPreviousAndBackButton.cupertino(
      {super.key, required this.bloc, required this.label})
      : _isMaterial = false;

  @override
  Widget build(BuildContext context) {
    return _isMaterial ? materialWidget() : cupertinoWidget();
  }

  cupertinoWidget() {
    return CupertinoButton(
      onPressed: handleOnTap,
      child: Text(
        label,
      ),
    );
  }

  GestureDetector materialWidget() {
    return GestureDetector(
      onTap: handleOnTap,
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

  void handleOnTap() {
    final index = bloc.steps.indexWhere((element) => element.isCurrentStep);
    if (index != 0) {
      bloc.steps[index].isCurrentStep = false;
      bloc.steps[index - 1].isCurrentStep = true;
      bloc.currentStep = bloc.steps[index - 1];
      bloc.add(UpdateUiEvent());
    }
  }
}
