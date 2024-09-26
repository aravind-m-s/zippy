import 'package:flutter/material.dart';
import 'package:zippy/src/controllers/bloc/zippyform_bloc.dart';
import 'package:zippy/src/zippy.dart';

class StepLabelWidget extends StatelessWidget {
  const StepLabelWidget({
    super.key,
    required this.bloc,
    required this.widget,
  });

  final ZippyFormBloc bloc;
  final ZippyForm widget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      child: Row(
        children: List.generate(
          bloc.steps.length,
          (index) => Padding(
            padding: EdgeInsets.only(
                left: index == 0 ? widget.horizontalPadding : 0,
                right: index == bloc.steps.length - 1
                    ? widget.horizontalPadding
                    : 0),
            child: SizedBox(
              width: 175,
              child: Text(
                bloc.steps[index].name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
