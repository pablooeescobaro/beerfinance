import 'package:beer_app/data/dto/finance.dart';
import 'package:json_annotation/json_annotation.dart';

part 'saving.g.dart';

@JsonSerializable()
class SavingModel {
  String? id;
  int? amount;
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
}
