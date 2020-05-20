import 'package:flutter_money_formatter/flutter_money_formatter.dart';

class Formatter{
  String format(var value){
    
    var jumlah = FlutterMoneyFormatter(
    amount: double.parse('$value'),
    settings: MoneyFormatterSettings(
      fractionDigits: 0,
    )).output;
   
   return jumlah.nonSymbol;
  }
}