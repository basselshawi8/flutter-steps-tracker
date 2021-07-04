import 'package:intl/intl.dart';

class Formatter {
  static RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  static Function mathFunc = (Match match) => '${match[1]},';

  static String formatNumber(double number) {
    return number.round().toString().replaceAllMapped(reg, mathFunc);
  }

  static String formatPhoneNumber(String number) {
    if (number == null) return null;
    String resPhone = '+963 ';
    number = number.substring(1, number.length);
    resPhone += number[0] + number[1] + ' ';
    number = number.substring(2, number.length);
    resPhone +=
        number.substring(0, 3) + ' ' + number.substring(3, number.length);
    return resPhone;
  }

  static String formatter(String _price) {
    double value = double.parse(_price);

    final formatter = new NumberFormat("###,###.###", "en_US");

    String newText = formatter.format(value);
    return newText;
  }

//  static String formatDate({String date,BuildContext context}){
//    var _formatedDate;
//    DateTime _date = DateTime.tryParse(date);
//    if(_date == null){
//      try {
//        DateTime _trydate = DateTime.parse(date.substring(0,10));
//        _formatedDate = Jiffy(_date, 'yyy/MM/dd');
////        int _difference = _date.difference(DateTime.now()).inDays;
//        int _difference = DateTime.now().difference(_date).inDays;
//        if(_difference == 0)
//          return _formatedDate.jm.toString();
//        else if(_difference  > 0  &&  _difference < 31)
//        {
//          return MaterialLocalizations.of(context).formatMediumDate(_date)+"  " +_formatedDate.jm.toString();
//        }
//        else if(_difference  >= 31 )
//        {
//          return MaterialLocalizations.of(context).formatFullDate(_date);
//        }
//        else return MaterialLocalizations.of(context).formatMediumDate(DateTime.now()).toString();
//      } catch (e) {
//        print(e);
//        return MaterialLocalizations.of(context).formatMediumDate(DateTime.now()).toString();
//      }
//    }
//    else
//      _formatedDate = Jiffy(_date, 'yyy/MM/dd');
//    int _difference = DateTime.now().difference(_date).inDays;
//    if(_difference == 0)
//      return _formatedDate.jm.toString();
//    else if(_difference  > 0  &&  _difference < 31)
//    {
//      return MaterialLocalizations.of(context).formatMediumDate(_date)+"  " +_formatedDate.jm.toString();
//    }
//    else if(_difference  >= 31 )
//    {
//      return MaterialLocalizations.of(context).formatFullDate(_date);
//    }
//    else
//      return MaterialLocalizations.of(context).formatMediumDate(DateTime.now()).toString();
//  }

}
