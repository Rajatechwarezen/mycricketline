import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:html/dom.dart' as htmlDom;
import 'package:mycricketline/utils/Style.dart';

Widget myHtmlWidget(String htmlContent) {
  return HtmlWidget(
    htmlContent,
    textStyle: TextStyle(fontSize: 12),
    customStylesBuilder: (element) {
      if (element.nodes.contains('p')) {
        return {
          'font-size': '10px',
          'color': 'blue',
          'font-weight': '700',
          "text-align": "center",
        };
      }
      return {
        "text-align": "center",
        'font-size': '15px',
        'color': 'blue',
        'margin': '8px 0',
        'font-weight': '700',
      };
    },
  );
}

List<String> extractTextFromHtml(String htmlContent) {
  List<String> textArray = [];

  // Parse the HTML content
  htmlDom.Document document = htmlDom.Document.html(htmlContent);

  // Function to recursively extract text from the HTML elements
  void extractText(htmlDom.Node node) {
    if (node is htmlDom.Text) {
      textArray.add(node.text.trim());
    } else if (node is htmlDom.Element) {
      node.nodes.forEach((childNode) {
        extractText(childNode);
      });
    }
  }

  // Start extracting text from the root of the document
  document.nodes.forEach((node) {
    extractText(node);
  });

  return textArray;
}

Widget buildColumn(data) {
  List<TableRow> tableRows = [];
  List innerColumn = [];
  List<String> firstInningsData = [];

  for (String item in data) {
    if (item.isNotEmpty) {
      TextStyle textStyle = TextStyle(fontSize: 14);

      if (item.startsWith("DAY")) {
        textStyle = const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
      } else if (item.startsWith("India tour") || item.startsWith("Venue")) {
        textStyle = const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
      } else if (item.startsWith("Toss -") || item.startsWith("LIVE ON")) {
        textStyle = const TextStyle(fontSize: 14, fontStyle: FontStyle.italic);
      }

      if (item.startsWith("DAY")) {
        textStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
        innerColumn.add(item);
      }
      if (item.startsWith("1st Inns Score")) {
        textStyle = CustomStyles.cardBoldDarkDrawerTextStyle;
        innerColumn.add(item);
      }
      tableRows.add(TableRow(
        children: [
          TableCell(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5),
              child: Text(
                item,
                style: textStyle,
              ),
            ),
          ),
        ],
      ));
    }
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Table(
        columnWidths: const {
          0: FlexColumnWidth(0.8)
        }, // Adjust column width as needed
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,

        border: TableBorder.all(color: Colors.grey),
        children: tableRows,
      ),
    ],
  );
}

// Widget buildColumn(data) {
//   List<String> firstInningsData = [];
//   print(data);
//   for (String item in data) {
//     if (item.startsWith("DAY 1, IND 1st Inns Score")) {
//       firstInningsData = item.split(" - ")[1].split(", ");
//       break;
//     }
//   }

//   // String runs = firstInningsData[0].split("/")[0] ?? " ";
//   // String wk = firstInningsData[0].split("/")[1].split(" ")[0] ?? " ";
//   // String ovs = firstInningsData[1].replaceAll("Ovs", "").trim() ?? " ";

//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Table(
//         columnWidths: {
//           0: FixedColumnWidth(80.0),
//           1: FixedColumnWidth(80.0),
//           2: FixedColumnWidth(80.0)
//         },
//         defaultVerticalAlignment: TableCellVerticalAlignment.middle,
//         border: TableBorder.all(color: Colors.grey),
//         children: [
//           // buildTableRow(["Ovs", "Runs", "0wk"]),
//           // buildTableRow([ovs, runs, wk]),
//         ],
//       ),
//     ],
//   );
// }

// TableRow buildTableRow(List<String> rowData) {
//   return TableRow(
//     children: rowData.map((item) {
//       return TableCell(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8.0),
//           child: Text(
//             item,
//             style: TextStyle(fontSize: 14),
//           ),
//         ),
//       );
//     }).toList(),
//   );
// }
