import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zippy/src/controllers/bloc/zippyform_bloc.dart';
import 'package:zippy/src/widgets/button/top_next_button.dart';
import 'package:zippy/src/widgets/button/top_previous_button.dart';
import 'package:zippy/src/zippy.dart';

class TopButtons extends StatelessWidget {
  const TopButtons.material({
    super.key,
    required this.bloc,
    required this.widget,
  }) : _isMaterial = true;

  const TopButtons.cupertino({
    super.key,
    required this.bloc,
    required this.widget,
  }) : _isMaterial = false;

  final ZippyFormBloc bloc;
  final ZippyForm widget;
  final bool _isMaterial;

  @override
  Widget build(BuildContext context) {
    return _isMaterial ? materialwidget() : cupertinoWidget();
  }

  CupertinoNavigationBar cupertinoWidget() {
    return CupertinoNavigationBar(
      leading: TopPreviousAndBackButton.cupertino(
        bloc: bloc,
        label: getPreviousLabel(),
      ),
    );
  }

  AppBar materialwidget() {
    return AppBar(
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.white,
      elevation: 0.5,
      leadingWidth: 100,
      shadowColor: Colors.grey,
      leading: TopPreviousAndBackButton.material(
        bloc: bloc,
        label: getPreviousLabel(),
      ),
      actions: [
        TopNextAndSubmitButton(
          bloc: bloc,
          label: getNextLabel(),
          hiddenFields: widget.hiddenFields,
        ),
      ],
    );
  }

  String getNextLabel() {
    return bloc.steps.indexOf(bloc.currentStep) == bloc.steps.length - 1
        ? widget.submitButtonText
        : widget.nextButtonText;
  }

  String getPreviousLabel() {
    return bloc.steps.indexOf(bloc.currentStep) == 0
        ? widget.backButtonText
        : widget.previousButtonText;
  }
}
