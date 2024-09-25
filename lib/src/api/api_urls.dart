class ApiUrls {
  static const String _baseUrl = "https://api.zippyform.io/api/v1/form";

  static getAllFieldsUrl(String formId, String stepId) {
    return "$_baseUrl/dynamic-form/$formId/fields${stepId.isNotEmpty ? "/$stepId" : ""}";
  }

  static getStepSubmissionUrl(
      String formId, String stepId, String submissionId) {
    return "$_baseUrl/dynamic-form/$formId/submit/$stepId${submissionId.isNotEmpty ? "/$submissionId" : ""}";
  }
}
