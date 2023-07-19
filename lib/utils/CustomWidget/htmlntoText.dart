String convertDataToText(String data) {
  // Remove HTML tags and special characters
  String cleanedData = data.replaceAll(RegExp(r"<.*?>"), "").trim();

  // Split the cleaned data into lines
  List<String> lines = cleanedData.split("\n");

  // Remove empty lines
  lines.removeWhere((line) => line.trim().isEmpty);

  // Join the lines with appropriate formatting
  String formattedText = lines.join("\n");

  return formattedText;
}
