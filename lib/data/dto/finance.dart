import 'package:json_annotation/json_annotation.dart';

part 'finance.g.dart';

enum FinanceTypeEnum {
  INCOME,
  SPENDING,
  SAVING,
}

@JsonSerializable()
class FinanceModel {
  String? id;
  double? amount;
  String? name;
  FinanceTypeEnum? type;
  int? date;

  FinanceModel({this.id, this.amount, this.name, this.type, this.date});

  factory FinanceModel.fromJson(Map<String, dynamic> json) =>
      _$FinanceModelFromJson(json);

  Map<String, dynamic> toJson() => _$FinanceModelToJson(this);
}

@JsonSerializable()
class ListFinance {
  List<FinanceModel>? data;

  ListFinance({this.data});

  factory ListFinance.fromJson(Map<String, dynamic> json) =>
      _$ListFinanceFromJson(json);

  Map<String, dynamic> toJson() => _$ListFinanceToJson(this);
}

@JsonSerializable()
class AllFinanceModel {
  double allIncome;
  double allSpending;
  double allSavings;

  AllFinanceModel({
    this.allIncome = 0,
    this.allSpending = 0,
    this.allSavings = 0,
  });

  factory AllFinanceModel.fromJson(Map<String, dynamic> json) =>
      _$AllFinanceModelFromJson(json);

  Map<String, dynamic> toJson() => _$AllFinanceModelToJson(this);
}
