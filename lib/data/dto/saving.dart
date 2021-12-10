import 'package:beer_app/data/dto/finance.dart';
import 'package:json_annotation/json_annotation.dart';

part 'saving.g.dart';

@JsonSerializable()
class SavingModel {
  String? id;
  double? amount;
  String? name;
  FinanceTypeEnum? type;
  int? date;

  SavingModel({this.id, this.amount, this.name, this.type, this.date});

  factory SavingModel.fromJson(Map<String, dynamic> json) =>
      _$SavingModelFromJson(json);

  Map<String, dynamic> toJson() => _$SavingModelToJson(this);
}

@JsonSerializable()
class ListSaving {
  List<SavingModel>? data;

  ListSaving({this.data});

  factory ListSaving.fromJson(Map<String, dynamic> json) =>
      _$ListSavingFromJson(json);

  Map<String, dynamic> toJson() => _$ListSavingToJson(this);

  ListFinance toFinanceList(ListSaving? listSaving) {
    final list = <FinanceModel>[];
    if (listSaving != null && listSaving.data != null) {
      for (var e in listSaving.data ?? []) {
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
