import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column;

Future<void> generateExcel({required className, required mapOfEntries}) async {
  String className = "";
  Map<String, List<String>> mapOfEntries = <String, List<String>>{};
  int currentIndex = 4;
  final Workbook workbook = Workbook();
  final Worksheet sheet = workbook.worksheets[0];
  sheet.showGridlines = true;

  sheet.enableSheetCalculations();

//SHEET SETUP

  sheet.getRangeByName("A1").columnWidth = 20;
  sheet.getRangeByName("A1:D2").merge();
  sheet.getRangeByName("A1").setText(className);
  sheet.getRangeByName("A1").cellStyle.fontSize = 22;
  sheet.getRangeByName("A1").setText("Child Name");
  sheet.getRangeByName("A3").cellStyle.bold = true;

  // for (var child in mapOfEntries) {
  //   sheet.getRangeByName("A$currentIndex").setText(child);
  //   currentIndex++;
  // }
}
