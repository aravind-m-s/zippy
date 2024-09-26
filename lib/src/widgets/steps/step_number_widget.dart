import 'package:flutter/material.dart';
import 'package:zippy/src/core/app_colors.dart';

class StepNumberWidget extends StatelessWidget {
  final int index;
  const StepNumberWidget({
    super.key,
    required this.currentStepIndex,
    required this.index,
  });

  final int currentStepIndex;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: currentStepIndex >= index
          ? AppColors.zippyPrimaryColor
          : AppColors.zippyPrimaryColor.withOpacity(0.15),
      radius: 30,
      child: Text(
        (index + 1).toString(),
        style: TextStyle(
          fontSize: 24,
          color: currentStepIndex >= index
              ? Colors.white
              : AppColors.zippyPrimaryColor,
        ),
      ),
    );
  }
}
