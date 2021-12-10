import 'package:beer_app/data/dto/finance.dart';
import 'package:intl/intl.dart';

String parseDate(int date, {String dateFormat = 'dd.MM'}) {
  final formatter = DateFormat(dateFormat);
  return formatter.format(
      DateTime.fromMillisecondsSinceEpoch(date).add(const Duration(hours: 2)));
}

String parseAmount(double? amount, FinanceTypeEnum? type,
    {bool withIndicator = true}) {
  switch (type) {
    case FinanceTypeEnum.INCOME:
      return (withIndicator ? '+' : '') + parseBigAmount(amount) + '₴';
    case FinanceTypeEnum.SPENDING:
      return (withIndicator ? '-' : '') + parseBigAmount(amount) + '₴';
    case FinanceTypeEnum.SAVING:
      return (withIndicator ? '-' : '') + parseBigAmount(amount) + '₴';
    default:
      return '0.0';
  }
}

String parseBigAmount(double? amount) {
  if (amount != null && amount > 1000000) {
    return ((amount / 1000000).toStringAsFixed(1)).toString() + 'M';
  } else {
    return (amount ?? 0).toStringAsFixed(2);
  }
}
