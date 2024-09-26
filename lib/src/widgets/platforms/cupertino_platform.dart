import 'package:flutter/cupertino.dart';
import 'package:zippy/src/controllers/bloc/zippyform_bloc.dart';
import 'package:zippy/src/widgets/button/top_buttons.dart';
import 'package:zippy/src/zippy.dart';

class CupertinoPlatform extends StatelessWidget {
  const CupertinoPlatform({
    super.key,
    required this.widget,
    required this.bloc,
    required this.listener,
  });

  final ZippyForm widget;
  final ZippyFormBloc bloc;
  final Function(BuildContext, ZippyFormState) listener;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Column(
        children: [
          TopButtons.cupertino(
            bloc: bloc,
            widget: widget,
          ),
        ],
      ),
    );
  }
}
