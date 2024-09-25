class AppUtils {
  static int getFontSizeForStaticFields(String contentSize) {
    int fontSize = 0;
    switch (contentSize) {
      case "h1":
        fontSize = 34;
      case "h2":
        fontSize = 30;
      case "h3":
        fontSize = 26;
      case "h4":
        fontSize = 22;
      case "h5":
        fontSize = 18;
      case "h6":
        fontSize = 16;
      default:
        fontSize = (int.tryParse(contentSize) ?? 14) + 2;
    }

    return fontSize;
  }
}
