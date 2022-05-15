import 'package:intl/intl.dart';

String formattingDate({required String value, String pattern = 'yyyy-MM-dd'}) {
  DateTime parseDate = DateTime.parse(value);
  var outputFormat = DateFormat(pattern);
  var outputDate = outputFormat.format(parseDate);
  print(outputDate);
  return outputDate;
}
