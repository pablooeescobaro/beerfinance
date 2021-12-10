import 'package:beer_app/data/dto/finance.dart';
import 'package:json_annotation/json_annotation.dart';

part 'income.g.dart';

enum IncomeCategoryEnum { MAININCOME, SIDEINCOME }

final IncomeCategoryEnumMap = {
  'Основной доход': IncomeCategoryEnum.MAININCOME,
  'Подработка': IncomeCategoryEnum.SIDEINCOME,
};

final IncomeCategoryEnumMapReverse = {
  IncomeCategoryEnum.MAININCOME: 'Основной доход',
  IncomeCategoryEnum.SIDEINCOME: 'Подработка',
};

@JsonSerializable()
class IncomeModel {
  String? id;
  double? amount;
  String? name;
  IncomeCategoryEnum? category;
  FinanceTypeEnum? type;
  int? date;

  IncomeModel(
      {this.id, this.amount, this.name, this.category, this.type, this.date});

  factory IncomeModel.fromJson(Map<String, dynamic> json) =>
      _$IncomeModelFromJson(json);

  Map<String, dynamic> toJson() => _$IncomeModelToJson(this);
}

@JsonSerializable()
class ListIncome {
  List<IncomeModel>? data;

  ListIncome({this.data});

  factory ListIncome.fromJson(Map<String, dynamic> json) =>
      _$ListIncomeFromJson(json);

  Map<String, dynamic> toJson() => _$ListIncomeToJson(this);

  ListFinance toFinanceList(ListIncome? listIncome) {
    final list = <FinanceModel>[];
    if (listIncome != null && listIncome.data != null) {
      for (var e in listIncome.data ?? []) {
        list.add(FinanceModel(
            id: e.id,
            name: e.name,
            type: e.type,
            amount: e.amount,
            date: e.date));
      }
      return ListFinance(data: list);
    } else {
      return ListFinance();
    }
  }
}
