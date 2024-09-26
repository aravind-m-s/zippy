import 'package:flutter/material.dart';
import 'package:zippy/src/controllers/bloc/zippyform_bloc.dart';
import 'package:zippy/src/core/app_colors.dart';
import 'package:zippy/src/widgets/steps/step_label_widget.dart';
import 'package:zippy/src/widgets/steps/step_number_widget.dart';
import 'package:zippy/src/zippy.dart';

class StepsWidget extends StatelessWidget {
  const StepsWidget({
    super.key,
    required this.bloc,
    required this.widget,
    required this.currentStepIndex,
  });

  final ZippyFormBloc bloc;
  final ZippyForm widget;
  final int currentStepIndex;

  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      maxHeight: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: List.generate(
                  bloc.steps.length,
                  (index) => Padding(
                    padding: EdgeInsets.only(
                        left: index == 0 ? widget.horizontalPadding : 0,
                        right: index == bloc.steps.length - 1
                            ? widget.horizontalPadding
                            : 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (index != 0)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: Container(
                              height: 1,
                              width: 100,
                              color: currentStepIndex >= index
                                  ? AppColors.zippyPrimaryColor
                                  : AppColors.zippyPrimaryColor
                                      .withOpacity(0.15),
                            ),
                          ),
                        StepNumberWidget(
                          currentStepIndex: currentStepIndex,
                          index: index,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              StepLabelWidget(bloc: bloc, widget: widget)
            ],
          ),
        ],
      ),
    );
  }
}
