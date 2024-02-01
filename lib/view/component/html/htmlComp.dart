

import 'package:html/dom.dart';
import 'package:html/parser.dart';

String extractTextFromHtml(String htmlContent) {
  var document = parse(htmlContent);
  return extractTextFromNode(document.body);
}

String extractTextFromNode( node) {
  var buffer = StringBuffer();

  void processNode(Node node) {
    if (node is Text) {
      buffer.write(node.text);
    } else if (node is Element) {
      for (var childNode in node.nodes) {
        processNode(childNode);
      }
      if (node.localName == 'br') {
        buffer.writeln();
      }
    }
  }

  processNode(node);

  return buffer.toString();
}