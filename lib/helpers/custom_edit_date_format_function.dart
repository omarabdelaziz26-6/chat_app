import 'package:intl/intl.dart';

String customEditDateFormatFunction({required String dateAsString}) {
  DateTime x = DateTime.parse(dateAsString);
  String y = DateFormat("hh:mm  d,M,y").format(x);
  // var z = DateFormat.yMMMMd().format(x);
  // log(y.toString());
  return y;
}
String customDateFormatFunction({required String dateAsString}) {
  DateTime x = DateTime.parse(dateAsString);
  String y = DateFormat("d,M,y").format(x);
  // var z = DateFormat.yMMMMd().format(x);
  // log(y.toString());
  return y;
}