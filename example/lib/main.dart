import 'package:flutter/material.dart';
import 'package:zippy/zippy.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final hiddenFields = {"sdkfjdsfd": "sdlkfjsd"};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ZippyForm(
          formId: "7a3d70d3-ad08-4c2d-880c-b37e89c59ff4",
          debugMode: true,
          errorWidget: showSnackBar,
          hiddenFields: hiddenFields,
          onSubmitted: showSnackBar2,
        ),
      ),
    );
  }

  showSnackBar(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  showSnackBar2(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Success"),
      ),
    );
  }
}
