import 'package:beer_app/data/dto/finance.dart';
import 'package:json_annotation/json_annotation.dart';

part 'income.g.dart';

enum IncomeCategoryEnum { MAININCOME, SIDEINCOME }

final IncomeCategoryEnumMap = {
  'Основной доход': IncomeCategoryEnum.MAININCOME,
  'Подработка': IncomeCategoryEnum.SIDEINCOME,
};

@JsonSerializable()
class IncomeModel {
  String? id;
  int? amount;
  String? name;
  IncomeCategoryEnum? category;
  FinanceTypeEnum? type;
  int? date;

  IncomeModel({this.id, this.amount, this.name, this.category, this.type, this.date});

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
}
