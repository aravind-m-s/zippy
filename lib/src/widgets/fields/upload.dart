import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:zippy/src/controllers/bloc/zippyform_bloc.dart';
import 'package:zippy/src/core/app_colors.dart';
import 'package:zippy/src/models/upload.dart';
import 'package:flutter/material.dart';

class UploadField extends StatefulWidget {
  final UploadModel field;
  final ZippyFormBloc bloc;
  const UploadField({super.key, required this.field, required this.bloc});

  @override
  State<UploadField> createState() => _UploadFieldState();
}

class _UploadFieldState extends State<UploadField> {
  @override
  Widget build(BuildContext context) {
    final filePath = widget.bloc.uploadValues[widget.field.fieldId];
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () async {
        final file = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowMultiple: false,
          allowedExtensions: widget.field.validations.fileExtensionsAllowed,
        );
        if (file != null && file.files.isNotEmpty) {
          widget.bloc.uploadValues[widget.field.fieldId] =
              file.files.first.path ?? "";
        }
        setState(() {});
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          border: Border.all(
            color: widget.bloc.errors[widget.field.fieldId] != null
                ? AppColors.zippyErrorColor
                : AppColors.zippyBorderColor,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            const Icon(
              Icons.file_upload_outlined,
              size: 40,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              filePath == null || filePath.isEmpty
                  ? widget.field.placeholder
                  : filePath.split("/").last,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            if (filePath != null && filePath.isNotEmpty)
              Text(
                formatBytes(File(filePath).lengthSync()),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
            if (filePath != null && filePath.isNotEmpty)
              Text(
                filePath.split(".").last.toUpperCase(),
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              )
          ],
        ),
      ),
    );
  }

  String formatBytes(int bytes) {
    if (bytes <= 0) return "0 B";
    const int kB = 1024;
    const int mB = kB * 1024;
    const int gB = mB * 1024;

    if (bytes >= gB) {
      return "${(bytes / gB).toStringAsFixed(2)} GB";
    } else if (bytes >= mB) {
      return "${(bytes / mB).toStringAsFixed(2)} MB";
    } else if (bytes >= kB) {
      return "${(bytes / kB).toStringAsFixed(2)} KB";
    } else {
      return "$bytes B";
    }
  }
}
