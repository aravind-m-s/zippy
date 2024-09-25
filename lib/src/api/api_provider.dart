import 'dart:developer';

import 'package:http/http.dart';
import 'package:zippy/src/api/api_urls.dart';

class ApiProvider {
  static getAllFields(String formId, String stepId, bool debugMode) async {
    try {
      final url = Uri.parse(ApiUrls.getAllFieldsUrl(formId, stepId));
      final request = MultipartRequest("GET", url);
      final response = await request.send();
      return Response.fromStream(response);
    } catch (e, s) {
      if (debugMode) {
        log("-------------- Get All Fields Api Call --------------",
            error: e, stackTrace: s);
      }
      return e;
    }
  }

  static getAdvancedDropdownFields(String getAdvancedDropdownFields) async {
    try {
      final request =
          MultipartRequest("GET", Uri.parse(getAdvancedDropdownFields));
      final response = await request.send();
      return Response.fromStream(response);
    } catch (e) {
      return e;
    }
  }

  static submitDataForStep(
    String formId,
    String stepId,
    String submissionId,
    final Map<String, String> fields,
    final List<MultipartFile> files,
  ) async {
    try {
      final request = MultipartRequest(
          "POST",
          Uri.parse(
              ApiUrls.getStepSubmissionUrl(formId, stepId, submissionId)));
      request.fields.addAll(fields);
      request.files.addAll(files);
      final response = await request.send();
      return Response.fromStream(response);
    } catch (e) {
      return e;
    }
  }
}
